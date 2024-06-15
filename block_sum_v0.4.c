#include<stdio.h>
#include<math.h>

//#define BUF_SIZE 100
//#define WS 1000 //window size
//#define FREQ_UNDER 800	//Hz
//#define FREQ_UPPER 1000	//Hz
#define THRESHOLD 20
#define N 256

int main(int argc,char **argv){
	FILE *fp=NULL;
//	double t=0,t_old,signal,sum=0;
	double signal,sum=0;
	int freq;
	int freq_c;
	int start_freq,end_freq;
	char str[N];

	fp=fopen(argv[1],"r");
	if(fp!=NULL){
		start_freq=atoi(argv[2]);
		end_freq=atoi(argv[3]);

//		t_old=t;
		freq_c=start_freq;
//		while(fscanf(fp,"%lf %d %lf",&t,&freq,&signal)!=EOF){
//		while(fscanf(fp,"%lf",&signal)!=EOF){
		while(fgets(str,N,fp)!=NULL){
//			printf("%s",str);
			if(*str=='\n'){
//				printf("%f %f\n",t,sum);
				printf("%.1f\n",sum);
				sum=0;
				freq_c=start_freq;
//				t_old=t;
//			}else if(FREQ_UNDER<=freq&&freq<=FREQ_UPPER&&THRESHOLD<signal)
//			}else if(FREQ_UNDER<=freq_c&&freq_c<=FREQ_UPPER&&THRESHOLD<signal)
			}else if(start_freq<=freq_c&&freq_c<=end_freq){
				signal=atoi(str);
				sum+=signal;
				freq_c++;
			}
		}
		fclose(fp);

//		printf("%f %f\n",t,sum);
		printf("%.1f\n",sum);

	}else{
		printf("%s:ファイルのオープンに失敗\n",argv[1]);
	}


	return 0;
}
