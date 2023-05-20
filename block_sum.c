#include<stdio.h>
#include<math.h>

//#define BUF_SIZE 100
//#define WS 1000 //window size
#define FREQ_UNDER 870
#define FREQ_UPPER 930
#define THRESHOLD 20


int main(int argc,char **argv){
	FILE *fp=NULL;
	double t=0,t_old,signal,sum=0;
	int freq;

	fp=fopen(argv[1],"r");
	if(fp!=NULL){

		t_old=t;
		while(fscanf(fp,"%lf %d %lf",&t,&freq,&signal)!=EOF){
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
