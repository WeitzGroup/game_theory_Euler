//
//  innout.c
//  innout means input and output functions
//
//  Created by Yu-Hui Lin on 5/18/17.
//
//
void print_d_vec(double* x,long length, FILE* fp){
	int i;
	for(i = 0; i < length; i++){
		fprintf(fp,"%.8le\t",x[i]);
	}
    fprintf(fp,"\n");
}

void print_d_mat2(double** x,long n_row,long n_col, FILE* fp){
	int i,j;
	for(i = 0; i < n_row; i++){
		for(j = 0; j < n_col; j++){
			fprintf(fp,"%.8le\t",x[i][j]);
		}
		fprintf(fp,"\n");
	}
}

void print_boolean_mat2(double** x,long n_row,long n_col, FILE* fp){
    int i,j;
    for(i = 0; i < n_row; i++){
        for(j = 0; j < n_col; j++){
            fprintf(fp,"%.0lf\t",x[i][j]);
        }
        fprintf(fp,"\n");
    }
}

void print_layer_d_mat2(double*** x,long n_row,long n_col, long layer, FILE* fp){
	int i,j;
	for(i = 0; i < n_row; i++){
		for(j = 0; j < n_col; j++){
			fprintf(fp,"%.8le\t",x[i][j][layer]);
		}
		fprintf(fp,"\n");
	}
}

void print_layer_boolean_mat2(double*** x,long n_row,long n_col, long layer, FILE* fp){
	int i,j;
	for(i = 0; i < n_row; i++){
		for(j = 0; j < n_col; j++){
			fprintf(fp,"%.0lf\t",x[i][j][layer]);
		}
		fprintf(fp,"\n");
	}
}


double* read_d_vec(char filename[], long length){
	int i;
	FILE* fp;
	double* x;
	
	fp = fopen(filename,"r");
	for(i = 0; i < length; i++){
		fscanf(fp,"%le\t",&x[i]);
	}
	fclose(fp);
	
	return x;
}

double** read_d_mat(char filename[], long n_row, long n_col){
	int i, j;
	FILE* fp;
	double** x;
	
	fp = fopen(filename,"r");
	for(i = 0; i < n_row; i++){
		for(j = 0; j < n_col; j++){
			fscanf(fp,"%le\t",&x[i][j]);
		}
	}
	
	return x;
}
