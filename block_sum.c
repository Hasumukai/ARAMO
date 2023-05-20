#include<stdio.h>
#include<math.h>

//#define BUF_SIZE 100
//#define WS 1000 //window size
#define FREQ_UNDER 870
#define FREQ_UPPER 930
#define THRESHOLD 20


int main(int argc,char **argv){
	FILE *fp=NULL;
//	char *filename="FILE.dat";
//	char dump[100];
	double t=0,t_old,signal,sum=0;
//	double buffer[WS],rms;
//	int indx=0,i;
	int freq;

//	fp=fopen(filename,"r");
	fp=fopen(argv[1],"r");
	if(fp!=NULL){
//		printf("file open:%s\n",argv[1]);

		t_old=t;
		while(fscanf(fp,"%lf %d %lf",&t,&freq,&signal)!=EOF){
//			printf("I:%f %f\n",t,signal);
//			buffer[indx%WS]=signal;

			if(t_old!=t){
				printf("%f %f\n",t,sum);
				sum=0;
				t_old=t;
			}else if(FREQ_UNDER<=freq&&freq<=FREQ_UPPER&&THRESHOLD<signal)
				sum+=signal;
		}
		fclose(fp);

		printf("%f %f\n",t,sum);

	}else{
		printf("%s:ファイルのオープンに失敗\n",argv[1]);
	}


	return 0;
}
