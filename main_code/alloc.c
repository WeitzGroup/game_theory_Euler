//
//  alloc.c
//  allocation of 1-D vector and 2-D matrix
//	d_* means double vec / array
//
//  Created by Yu-Hui Lin on 5/18/17.
//
//

/*Standard error handler*/
void message_error(char error_text[]){
	printf("There are some errors...\n");
	printf("%s\n", error_text);
	printf("...now existing to system...\n");
	exit(1);
}

double *d_vec(long length){
	double *x;
	x = (double *)malloc((size_t)(length)*sizeof(double));
	if(x == NULL)message_error("allocation failure in d_vec()");
	return x;
}

double **d_mat2(long n_row, long n_col){
	double **x;
	long i;
	x = (double **)malloc((size_t)(n_row)*sizeof(double *));
	if(x == NULL){message_error("allocation failure in d_mat2()");}
	x[0] = (double *)malloc((size_t)(n_row*n_col*sizeof(double)));
	if(x[0] == NULL){message_error("allocation failure in d_mat2()");}
	
	for(i = 1; i < n_row; i++){x[i] = x[0] + i*n_col;}
	return x;
}

double ***d_mat3(long n_row, long n_col, long n_layer){
	double ***x;
	long i, j, k;
	x = (double ***)malloc((size_t)(n_row)*sizeof(double **));
	if(x == NULL){message_error("allocation failure in d_mat3()");}
	x[0] = (double **)malloc((size_t)(n_row*n_col*sizeof(double *)));
	if(x[0] == NULL){message_error("allocation failure in d_mat3()");}
	x[0][0] = (double *)malloc((size_t)(n_row*n_col*n_layer*sizeof(double)));
	if(x[0][0] == NULL){message_error("allocation failure in d_mat3()");}
	
	for(i = 0; i < n_row; i++){
		x[i] = x[0] + i*n_col;
		x[i][0] = x[0][0] + i*n_col*n_layer;
		for(j = 0; j < n_col; j++){
			x[i][j] = x[i][0] + j*n_layer;
		}
	}
	return x;
}

void free_d_vec(double *x){
	free(x);
}

void free_d_mat2(double **x){
	free(x[0]);
	free(x);
}

void free_d_mat3(double ***x){
	free(x[0][0]);
	free(x[0]);
	free(x);
}
