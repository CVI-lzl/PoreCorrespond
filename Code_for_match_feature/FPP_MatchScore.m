function FPP_MatchScore(length, output, K)
%   ���ݴ�ƥ���ȥα����б����ɶ�Ӧ����ͼ��ƥ�����
%   �˴���ʾ��ϸ˵��
    if K==1
        correspondroot=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���\',[num2str(length),'_',num2str(output)]);
        refinedroot=fullfile('E:\OCT\ƥ�亹��_Small\RANSAC\',[num2str(length),'_',num2str(output)]);
        cordinateroot=fullfile('E:\OCT\��ȡ����\Small\',['NEW_ASS_',num2str(floor(length/2))]);
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\matchscore\',[num2str(length),'_',num2str(output)]);
    elseif K==2
        correspondroot=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���\',num2str(length));
        refinedroot=fullfile('E:\OCT\ƥ�亹��_Small\WRANSAC\',num2str(length));
        cordinateroot=fullfile('E:\OCT\��ȡ����\Small\',['NEW_ASS_',num2str(floor(length/2))]);
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\matchscore_P\',num2str(length));
    elseif K==3
        correspondroot=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���\',num2str(output));
        refinedroot=fullfile('E:\OCT\ƥ�亹��_Small\WRANSAC\',num2str(output));
        cordinateroot=fullfile('E:\OCT\��ȡ����\Small\',['NEW_ASS_',num2str(floor(15))]);
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\matchscore_P\',num2str(output));
    end
    %RANSAC
    GP=load('E:\OCT\ƥ�亹��\GP.txt');
    IP=load('E:\OCT\ƥ�亹��\IP.txt');
    GPMS=zeros(3700,1);
    IPMS=zeros(21756,1);
    %GP
    for count=1:3700
        fp1=fullfile(cordinateroot,[num2str(GP(count,1)),'_',num2str(GP(count,2)),'_',num2str(GP(count,3)),'.txt']);
        fp2=fullfile(cordinateroot,[num2str(GP(count,4)),'_',num2str(GP(count,5)),'_',num2str(GP(count,6)),'.txt']);
        % pore���ױ�ʾ�����ȡ
        pore1=load(fp1);
        pore2=load(fp2);
        M=size(pore1,1);
        N=size(pore2,1);
        MIN=min(M,N);
        corres=load(fullfile(correspondroot,'GP',[num2str(count),'.txt']));
        conum=size(corres,1);            %��ƥ������
        refine=load(fullfile(refinedroot,'GP',[num2str(count),'.txt']));
        renum=size(refine,1);            %��ƥ������
        %GPMS(count,1)=(conum+renum)/(2*MIN);
        %GPMS(count,1)=renum/MIN;
        %GPMS(count,1)=renum-3;
        GPMS(count,1)=renum;
        fprintf('GP��%d�����\n',count);
    end
    dlmwrite(fullfile(outpath,'GP.txt'),GPMS);
    %IP 
    for count=1:21756
        fp1=fullfile(cordinateroot,[num2str(IP(count,1)),'_',num2str(IP(count,2)),'_',num2str(IP(count,3)),'.txt']);
        fp2=fullfile(cordinateroot,[num2str(IP(count,4)),'_',num2str(IP(count,5)),'_',num2str(IP(count,6)),'.txt']);
        % pore���ױ�ʾ�����ȡ
        pore1=load(fp1);
        pore2=load(fp2);
        M=size(pore1,1);
        N=size(pore2,1);
        MIN=min(M,N);
        corres=load(fullfile(correspondroot,'IP',[num2str(count),'.txt']));
        conum=size(corres,1);            %��ƥ������
        refine=load(fullfile(refinedroot,'IP',[num2str(count),'.txt']));
        renum=size(refine,1);            %��ƥ������
        %IPMS(count,1)=(conum+renum)/(2*MIN);
        %IPMS(count,1)=renum/MIN;
        %IPMS(count,1)=renum-3;
        IPMS(count,1)=renum;
        fprintf('IP��%d�����\n',count)
    end
    dlmwrite(fullfile(outpath,'IP.txt'),IPMS);
end