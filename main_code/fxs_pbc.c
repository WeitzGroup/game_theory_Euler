//
//  pbc_fxs.c
//
//  Other functions will be needed.
//  if depending on spatail coordinate,
//  all functions are based on periodic boundary condition
//  Created by Lin, Yu-Hui on 5/19/17.
//
//

///* defining coordinate with interger indices */
//struct coordinate{
//    int r;     // index of row
//    int c;     // index of column
//};

/* find index of neighbor lattice of (r_i, c_i)     */
/* on a 2D lattice site with nr rows and nc columns */
/* dir = 1(up), 2(right), 3(bottom), 4(left)        */
struct coordinate find_neighbor(long r_i, long c_i, long nr, long nc, long direc){
    
    struct coordinate coord;
    
    //dir = 1 (up) ,2 (right), 3 (bottom), or 4 (left)
    switch(direc){
        case 1:
            coord.r = (r_i+1)%nr;
            coord.c = c_i;
            break;
        case 2:
            coord.r = r_i;
            coord.c = (c_i+1)%nc;
            break;
        case 3:
            coord.r = (r_i+nr-1)%nr;
            coord.c = c_i;
            break;
        case 4:
            coord.r = r_i;
            coord.c = (c_i+nc-1)%nc;
            break;
    }
    return coord;
}

/* calculation diffusion on 2D domain */
double** diffu(double** before_diff, long nr, long nc, double D, double dx, double dt){
    double** after_diff;
    after_diff = d_mat2(nr, nc);
    int i, j;
    
    for(i = 0; i < nr; i++){
        for(j = 0; j < nc; j++){
            after_diff[i][j] = before_diff[i][j] +
            (D*dt/dx/dx)*(before_diff[(i+1)%nr][j] -2*before_diff[i][j] +before_diff[(i-1+nr)%nr][j])+
            (D*dt/dx/dx)*(before_diff[i][(j+1)%nc] -2*before_diff[i][j] +before_diff[i][(j-1+nc)%nc]);
        }
    }
    return after_diff;
}

/* calculate the value of n_dot  */
double n_dot(double x, double n, double theta){
    double ndot = n*(1-n)*(theta*x - (1-x));
    return ndot;
}

double payoff_n(double a0,double a1,double n){
    double an = a0*(1-n) + a1*n;
    return an;
}

/* doing average of x and n */
double* dyn_temp(double step, double **x, double **n){
    double* dyn_temp;
    int i, j;
    double x_avg = 0, n_avg = 0;
    
    dyn_temp = d_vec(3);
    
    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            x_avg += x[i][j];
            n_avg += n[i][j];
        }
    }
    x_avg = x_avg/(double)(L*L);
    n_avg = n_avg/(double)(L*L);
    dyn_temp[0] = step*dt;
    dyn_temp[1] = x_avg;
    dyn_temp[2] = n_avg;
    return dyn_temp;
}


void output_for_check(){
    if(spatial == 1){
        printf("Spatial simulation with parameters:\n");}
    else{
        printf("Non-spatial simulation with parameters:\n");}
    
    printf("[x0, n0] = ");
    printf("%.2lf %.2lf \n", x0, n0);
    
    if(spatial == 1){
        printf("D = ");
        printf("%.2lf \n", D);}
    
    
    printf("epsilon = ");
    printf("%.2lf \n", epsi);
    
    printf("theta = ");
    printf("%.2lf \n", theta);
    
    printf("[R0, S0; T0, P0] = ");
    printf("%.2lf %.2lf %.2lf %.2lf \n", R0, S0, T0, P0);
    
    printf("[R1, S1; T1, P1] = ");
    printf("%.2lf %.2lf %.2lf %.2lf \n", R1, S1, T1, P1);
    
    printf("L = ");
    printf("%d \n", L);
    
    printf("Tf = ");
    printf("%d \n", Tf);
    
    printf("dt = ");
    printf("%.2lf \n", dt);
    
}



