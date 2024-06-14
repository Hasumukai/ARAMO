//gcc fftw3_spectrogram.c -o fftw3_spectrogram -lm -lfftw3
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<fftw3.h>
#include<sys/time.h>
#include<time.h>

#define MAX 1000000
#define SRATE 120000 //sampling rate [Hz]
#define WINDOW_LENGTH 120000
//#define SHIFT_LENGTH 60000
//#define SHIFT_LENGTH 24000
#define SHIFT_LENGTH 120000
//#define START_FREQ 700
//#define END_FREQ 1100
//#define START_FREQ 0
//#define END_FREQ 2000

//void calc_fft(int BlockNumber,short *Ys,fftw_complex *in,fftw_complex *out);
void calc_fft(short *Ys,fftw_complex *in,fftw_complex *out,int start_freq,int end_freq);

int main (int argc,char **argv)
{
	FILE *fp;
	int i;
	short *Y; 
	int BlockSize=WINDOW_LENGTH*2;
	unsigned int fpStart;
	int ret;
	int add;
	fftw_complex *in, *out;
	struct timeval time_s,time_e;
	struct timespec time_sleep;
	double time_calc;
	int start_freq,end_freq;

	//time
	gettimeofday(&time_s,NULL);

	fp = fopen(argv[1], "r");
	if (fp == NULL){
			fprintf(stderr, "Can't open data file.\n");
			exit(-1);
	} 
	if(  ( Y=(short *)malloc(MAX) ) == NULL) {
			fprintf(stderr, "Can't allocate memory.\n");
			exit(-1);
	}

	fpStart=atoi(argv[2]);
	add=fpStart/SHIFT_LENGTH;
	fpStart*=2;	//1point = 2byte

	start_freq=atoi(argv[3]);
	end_freq=atoi(argv[4]);

	if(ret=fseek(fp, fpStart, SEEK_SET)){
			fprintf(stderr, "%d:fseek error.\n",ret);
			exit(-1);
   }
    if( fread(Y, sizeof(short), BlockSize, fp) == 0){
		fprintf(stderr,"read miss.");
		exit(-1);
	}
	fclose(fp);

	in = (fftw_complex*) fftw_malloc(sizeof(fftw_complex) * WINDOW_LENGTH);
	out = (fftw_complex*) fftw_malloc(sizeof(fftw_complex) * WINDOW_LENGTH);
	for(i=0;i*SHIFT_LENGTH<BlockSize/2;i++){
//		calc_fft(&Y[i*SHIFT_LENGTH],in,out);
//		calc_fft(i+add,&Y[i*SHIFT_LENGTH],in,out);
		calc_fft(&Y[i*SHIFT_LENGTH],in,out,start_freq,end_freq);
		printf("\n");
	}
	fftw_free(in); 
	fftw_free(out);

	free(Y);

	gettimeofday(&time_e,NULL);

	time_calc=1e9*(time_e.tv_sec-time_s.tv_sec)+1e3*(time_e.tv_usec-time_s.tv_usec);
	if(time_calc<1e9){
		time_sleep.tv_sec=0;
		time_sleep.tv_nsec=1e9-time_calc;
	
		nanosleep(&time_sleep,NULL);
	}

}

//void calc_fft(short *Ys,fftw_complex *in,fftw_complex *out){
//void calc_fft(int BlockNumber,short *Ys,fftw_complex *in,fftw_complex *out){
void calc_fft(short *Ys,fftw_complex *in,fftw_complex *out,int start_freq,int end_freq){
	fftw_plan p;
	double s,t,u;
	int i;

	/* Set input data; N is the number of data.  */
	for(i=0; i<WINDOW_LENGTH; i++){
		in[i][0]=Ys[i];
	}

	p = fftw_plan_dft_1d(WINDOW_LENGTH, in, out, FFTW_FORWARD, FFTW_ESTIMATE); 
	fftw_execute(p); 

	/* output the result */ 
//	for(i=START_FREQ; i<END_FREQ; i++){
	for(i=start_freq; i<end_freq; i++){
		s = out[i][0];		
		t = out[i][1];		
		u = sqrt(s*s + t*t)/1e4;
//		printf("%f \t %d \t %.5lf\n", (float)(BlockNumber)*SHIFT_LENGTH/SRATE,i, u);
		printf("%.1lf ",u);
//		printf("%.1lf\n",u);
	}

	fftw_destroy_plan(p);
}
