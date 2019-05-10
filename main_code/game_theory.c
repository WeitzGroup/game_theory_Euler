#include "header.h"

int main(int argc,char* argv[]){	
	rseed = atoi(argv[1]);
	srand(rseed);
	
	if(argc<2){
		printf("input an integer as random seed!\n");
		printf("./game_theory.out (randseed) \n");
		exit(0);}
	
	initialization("input.dat");
	
	if(argc>2){x0 = atof(argv[2]);}
	if(argc>3){n0 = atof(argv[3]);}
	if(argc>4){D = atof(argv[4]);}
	if(argc>5){epsi = atof(argv[5]);}
	if(argc>6){theta = atof(argv[6]);}
	if(argc>7){Tf = atof(argv[7]);}
	if(argc>8){L = atoi(argv[8]);}
	
	output_for_check();
	
	int i, j, k, l, m;
	int step = 0;
	int step_in_b = 0;		// step in buffer time window
	int N = L*L;
	double t, avg_x, avg_n, n_temp;
	double Rn, Sn, Tn, Pn;  // resource-depedent payoff
	double* dyn_t;          // dynamics of t, temporary dynamics at a time point
	double* focal_ind, * opponent_ind, * replaced_ind;
	double*** buff_x, *** buff_n;
	double** buff_dyn;
	struct coordinate focal, opponent, replaced;
	FILE *fp_x, *fp_n, *fp_dyn, *fp_final;
	char fn_x[150], fn_n[150], fn_dyn[150];
	
	x = d_mat2(L, L);   buff_x = d_mat3(L, L, b_step);
	n = d_mat2(L, L);   buff_n = d_mat3(L, L, b_step);
	dyn_t = d_vec(3);   buff_dyn = d_mat2(b_step, 3);
	
	/* assign filenames */
	if(spatial){
		if(D<10){
			sprintf(fn_x,"outfile/x_D%.1lf_x%.1lf_n%.1lf_rs%d_s.dat",D,x0,n0,rseed);
			sprintf(fn_n,"outfile/n_D%.1lf_x%.1lf_n%.1lf_rs%d_s.dat",D,x0,n0,rseed);
			sprintf(fn_dyn,"outfile/dyn_D%.1lf_x%.1lf_n%.1lf_rs%d_s.dat",D,x0,n0,rseed);
		}
		else{
			sprintf(fn_x,"outfile/x_DInf_x%.1lf_n%.1lf_rs%d_s.dat",x0,n0,rseed);
			sprintf(fn_dyn,"outfile/dyn_DInf_x%.1lf_n%.1lf_rs%d_s.dat",x0,n0,rseed);
		}
	}
	else{
		sprintf(fn_dyn,"outfile/dyn_x%.1lf_n%.1lf_rs%d_ns.dat",x0,n0,rseed);
	}
	/* assign initial conditions */
	for(i=0; i<L; i++){
		for(j=0; j<L; j++){
			x[i][j] = (double)(rand01()<=x0);
			n[i][j] = n0;
		}
	}
	
	dyn_t = dyn_temp(step, x, n);
	avg_x = dyn_t[1];
	avg_n = dyn_t[2];
	
	fp_dyn = fopen(fn_dyn,"w");
	
	if (spatial){
		fp_x = fopen(fn_x,"w");
		fprintf(fp_x,"#t=0\n");
		print_boolean_mat2(x,L,L,fp_x);
		fclose(fp_x);
		if(D<10){
			fp_n = fopen(fn_n,"w");
			fprintf(fp_n,"#t=0\n");
			print_d_mat2(n,L,L,fp_n);
			fclose(fp_n);
		}
	}
	print_d_vec(dyn_t,3,fp_dyn);
	
	fclose(fp_dyn);
	
	while(step < Tf){
		focal_ind = randperm(N);          // random shuffle index of focal players
		
		if(spatial==0){
			opponent_ind = randperm(N);       // random shuffle index of opponent players
			replaced_ind = randperm(N);       // random shuffle index of players replaced
		}
		
		/** looping through all players **/
		for(i = 0; i < N; i++){
			
			/** assigning opponent and players will be replaced **/
			focal.r = (int)floor((focal_ind[i]-1)/L);
			focal.c = (int)(focal_ind[i]-1)%L;
			if(spatial){
				double* neighbors = randperm(4);        // random shuffle the order of up, right, bottom, left
				opponent = find_neighbor(focal.r, focal.c, L, L, (int)neighbors[(int)floor(rand01()*4)]);
				replaced = find_neighbor(focal.r, focal.c, L, L, (int)neighbors[(int)floor(rand01()*4)]);

				//replaced = find_neighbor(focal.r, focal.c, L, L, (int)neighbors2[0]);
				if(D<10){n_temp = (n[focal.r][focal.c] + n[opponent.r][opponent.c])/2;}
				else{n_temp = avg_n;}
			}
			else{
				opponent.r = (int)floor((opponent_ind[i]-1)/L);
				opponent.c = (int)(opponent_ind[i]-1) % L;
				replaced.r = (int)floor((replaced_ind[i]-1)/L);
				replaced.c = (int)(replaced_ind[i]-1) % L;
				n_temp = avg_n;
			}
			/** calculation of resources-dependent payoff **/
			Rn = payoff_n(R0, R1, n_temp);
			Sn = payoff_n(S0, S1, n_temp);
			Tn = payoff_n(T0, T1, n_temp);
			Pn = payoff_n(P0, P1, n_temp);
			
			
			/** playing games **/
			double dice = rand01();
			if(x[focal.r][focal.c] == 1 && x[opponent.r][opponent.c] == 1){
				if(dice < Rn*(dt/epsi)){x[replaced.r][replaced.c] = 1;}
			}
			else if(x[focal.r][focal.c] == 1 && x[opponent.r][opponent.c] == 0){
				if(dice < Sn*(dt/epsi)){x[replaced.r][replaced.c] = 1;}
			}
			else if(x[focal.r][focal.c] == 0 && x[opponent.r][opponent.c] == 1){
				if(dice < Tn*(dt/epsi)){x[replaced.r][replaced.c] = 0;}
			}
			else if(x[focal.r][focal.c] == 0 && x[opponent.r][opponent.c] == 0){
				if(dice < Pn*(dt/epsi)){x[replaced.r][replaced.c] = 0;}
			}
		}
		for(i = 0; i < L; i++){
			for(j = 0; j < L; j++){
				buff_x[i][j][step_in_b] = x[i][j];
			}
		}
		
		
		
		/** update resources and do average of x and n**/
		if(spatial){
			dyn_t = dyn_temp(step+1,x,n);
			for(i = 0; i < L; i++){
				for(j = 0; j < L; j++){
					double nij = n[i][j];				// new varaibles to avoid possible reciprocal effect
					n[i][j] = nij + n_dot(x[i][j], nij, theta)*dt;

				}
			}
			
			// if small D, undergoes diffusion
			if(D<10){
				double** before_diff = n;					// new varaibles to avoid possible reciprocal effect
				n = diffu(before_diff, L, L, D, 1, dt);
				for(i = 0; i < L; i++){
					for(j = 0; j < L; j++){
						buff_n[i][j][step_in_b] = n[i][j];
					}
				}
			}
			// if large D, concentration goes to equilibrium quickly
			else{
				dyn_t = dyn_temp(step+1,x,n);
				for(i = 0; i < L; i++){
					for(j = 0; j < L; j++){
						n[i][j] = dyn_t[2];
					}
				}
			}
			
			dyn_t = dyn_temp(step+1, x, n);
			avg_x = dyn_t[1];
			avg_n = dyn_t[2];
			printf("step %d, n = %lf\n",step+1,avg_n);
		}
      	
		else{
	      		dyn_t = dyn_temp(step+1, x, n);
      			avg_x = dyn_t[1];
      			dyn_t[2] = avg_n + n_dot(avg_x, avg_n, theta)*dt;
      			avg_n = dyn_t[2];
		}
		
		for(i = 0; i < 3; i++){
			buff_dyn[step_in_b][i] = dyn_t[i];
		}
		
		step++;
		step_in_b++;
		
		/** output files is buffer is full **/
		if(step_in_b % b_step == 0){
			fp_dyn = fopen(fn_dyn,"a");
			// if small D, record both spatial profiles of x and n
			if (spatial && D<10){
				fp_x = fopen(fn_x,"a");
				fp_n = fopen(fn_n,"a");
				for(k = 0; k < b_step; k++){
					fprintf(fp_x,"#step = %d\n",step-b_step+k+1);
					fprintf(fp_n,"#step = %d\n",step-b_step+k+1);
					print_layer_boolean_mat2(buff_x,L,L,k,fp_x);
					print_layer_d_mat2(buff_n,L,L,k,fp_n);
				}
				fclose(fp_x);
				fclose(fp_n);
			}
			// if large D, record only spatial profiles of x since n equilibrated quickly
			if (spatial && D>=10){
				fp_x = fopen(fn_x,"a");
				for(k = 0; k < b_step; k++){
					fprintf(fp_x,"#step = %d\n",step-b_step+k+1);
					print_layer_boolean_mat2(buff_x,L,L,k,fp_x);
				}
				fclose(fp_x);
			}
			print_d_mat2(buff_dyn,b_step,3,fp_dyn);
			fclose(fp_dyn);
			step_in_b = 0;
		}
		
	}
	
	free_d_vec(dyn_t);
	free_d_vec(focal_ind);
	free_d_vec(opponent_ind);
	free_d_vec(replaced_ind);
	free_d_mat2(x);
	free_d_mat2(n);
	free_d_mat3(buff_x);
	free_d_mat3(buff_n);
	free_d_mat2(buff_dyn);
	
	return 0;
}

