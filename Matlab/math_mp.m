disp('1. Image to Sound Encoding')
disp('2. Sound to Image Decoding')
ch=input('Enter your choice ');
if ch==1
    img=input('Enter the image name with the complete filepath : ')
    aud=input('Enter the destination of the output audio with audio filename : ')
    img2song(img,aud);
end
if ch==2
    img=input('Enter the image name with the complete filepath : ')
    aud=input('Enter the destination of the output audio with audio filename : ')
    song2img(aud,img);
end

function img2song(img_filename,song_filename)
warning off
a=imread(img_filename);
[m n r]=size(a)
sizedata=[1 numsep(m)/10 1 numsep(n)/10 1 numsep(r)/10 1]
a=double(a);
a=(a-127.5)./127.5;
imgdata=reshape(a,1,m*n*r);
comdata=[sizedata imgdata];
[m n]=size(comdata)
if(rem(n,2)~=0)
    comdata=[comdata 1];
end
[m n]=size(comdata)
arrdata=reshape(comdata,n/2,2);
audiowrite(song_filename,arrdata,10000000) 
end

function song2img(song_filename,img_filename)
a=audioread(song_filename);
[m n]=size(a);
comdata=reshape(a,1,m*n);
comdata2=round(10*comdata);
ard=[];
for(i=1:m*n)
    if(comdata2(i)==10)
        ard=[ard i];
    end
end
num2=[];
for(j=1:3)
    ads=[];
    for(i=ard(j)+1:ard(j+1)-1)
        ads=[ads i];
    end
    ads=fliplr(ads);
    num=0;
    for(i=1:length(ads))
        gud=comdata2(ads(i))*(power(10,i-1));
        num=num+gud;
    end
    num2=[num2 num];
end
for(i=1:num2(1)*num2(2)*num2(3))
    comp_data(i)=comdata(i+ard(4));
end
img_data=reshape(comp_data,num2(1),num2(2),num2(3));
img_data=(img_data.*127.5)+127.5;
img_data=uint8(img_data);
imwrite(img_data,img_filename)
end

function output=numsep(a)
numcheck=10;
numdig=1;
while 1
if((a/numcheck)>1)
    numdig=numdig+1;
    numcheck=numcheck*10;
else,break
end
end
output=[];
for(i=1:numdig)
num=a-floor(a/10)*10;
output=[output num];
a=floor(a/10);
end
output=fliplr(output);
end