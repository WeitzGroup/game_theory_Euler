//
//  initialization.c
//  
//
//  Created by Lin, Yu-Hui on 5/18/17.
//  initialization of system
//
// fn_init: filename of input files of initial conditions

void initialization(char* fn_init){
    FILE *input, *initial_config;
    
    if((input=fopen(fn_init,"r"))==NULL){
        printf("File input.dat open error!\n");
        exit(0);}
    
    if(spatial == 1){
        printf("Spatial simulation with parameters:\n");}
    else{
        printf("Non-spatial simulation with parameters:\n");}

    fscanf(input, "%lf %lf", &x0, &n0);
    fscanf(input, " %lf", &D);
    fscanf(input, "%lf", &epsi);
    fscanf(input, "%lf", &theta);
    fscanf(input, "%lf %lf %lf %lf", &R0, &S0, &T0, &P0);
    fscanf(input, "%lf %lf %lf %lf", &R1, &S1, &T1, &P1);
    fscanf(input, "%d", &L);
    fscanf(input, "%d", &Tf);
    fscanf(input, "%lf", &dt);

    fclose(input);
    
    /* ensure no transition probability larger than 1*/
    double* prob;
    int i;
    prob = d_vec(8);
    prob[0] = R0*(dt/epsi); prob[1] = S0*(dt/epsi);
    prob[2] = T0*(dt/epsi); prob[3] = P0*(dt/epsi);
    prob[4] = R1*(dt/epsi); prob[5] = S1*(dt/epsi);
    prob[6] = T1*(dt/epsi); prob[7] = P1*(dt/epsi);
    for(i = 0; i < 8; i++){
        if(prob[i] > 1){
            printf("Transition probability too large!");
            exit(0);
        }
    }
    free_d_vec(prob);

}
