function FPP_Compare_MCP(length, output, K)
%   ָ��ƥ�䣺�ҵ����ƥ��ԣ����б�
%   �˴���ʾ��ϸ˵��
    if K==1
        porecoderoot=fullfile('E:\OCT\ƥ�亹��_Small\Pore deep feature code',[num2str(length),'_',num2str(output)]);
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���\',[num2str(length),'_',num2str(output)]); 
        mkdir(fullfile(outpath,'GP'));
        mkdir(fullfile(outpath,'IP'));
        % �������ڵ�ƥ��ֵ��TOP-K�����ٰ���ֵȡ�����֣�
        % �ҳ�Ҫ�Ƚϵ���ָ��ͼ����
        GP=load('E:\OCT\ƥ�亹��_Small\GP.txt');
        IP=load('E:\OCT\ƥ�亹��_Small\IP.txt');
    elseif K==2
        porecoderoot=fullfile('E:\OCT\ƥ�亹��_Small\Pore deep feature code',num2str(length));
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���',num2str(length)); 
        mkdir(fullfile(outpath,'GP'));
        mkdir(fullfile(outpath,'IP'));
        % �������ڵ�ƥ��ֵ��TOP-K�����ٰ���ֵȡ�����֣�
        % �ҳ�Ҫ�Ƚϵ���ָ��ͼ����
        GP=load('E:\OCT\ƥ�亹��_Small\GP.txt');
        IP=load('E:\OCT\ƥ�亹��_Small\IP.txt'); 
    elseif K==3
        porecoderoot=fullfile('E:\OCT\ƥ�亹��_Small\Pore deep feature code',num2str(output));
        outpath=fullfile('E:\OCT\ƥ�亹��_Small\��ƥ���',num2str(output)); 
        mkdir(fullfile(outpath,'GP'));
        mkdir(fullfile(outpath,'IP'));
        % �������ڵ�ƥ��ֵ��TOP-K�����ٰ���ֵȡ�����֣�
        % �ҳ�Ҫ�Ƚϵ���ָ��ͼ����
        GP=load('E:\OCT\ƥ�亹��_Small\GP.txt');
        IP=load('E:\OCT\ƥ�亹��_Small\IP.txt');
    end
    %GP�б�
    tic
    for count=1:3700
        fp1=fullfile(porecoderoot,[num2str(GP(count,1)),'_',num2str(GP(count,2)),'_',num2str(GP(count,3)),'.txt']);
        fp2=fullfile(porecoderoot,[num2str(GP(count,4)),'_',num2str(GP(count,5)),'_',num2str(GP(count,6)),'.txt']);
        % pore���ױ�ʾ������ȡ
        pore1=load(fp1);
        pore2=load(fp2);  
        num1=size(pore1,1);
        num2=size(pore2,1);
        %����ƥ���֮���
        Score=zeros(num1,num2);
        for j=1:num1
            for k=1:num2
                fea1=pore1(j,:);
                fea2=pore2(k,:);            
                %����ŷʽ����
                Score(j,k)=sqrt(sum((fea1-fea2).^2));
            end
        end
        %Ѱ�����ƥ��� 
        Pair =[  ];
        %%%%  FOR RANSAC
        for j=1:num1
            [m, in]=min(Score(j,:));
            [mv,inv]=min(Score(:,in));
            if (m==mv && inv ==j)
                Pair = cat(1, Pair, [j in]);
            end
        end
        %%%%  FOR WRANSAC
%         summ=0;
%         for j=1:num1
%             m=min(Score(j,:));
%             summ=summ+m;
%         end
%         threshold=summ/num1;
%         [M,N]=find(Score<=threshold);
%         Pair=[M N];
%         Pair=sortrows(Pair);
        %д��
        dlmwrite(fullfile(outpath,'GP',[num2str(count),'.txt']),Pair);
        fprintf('GP��%d�����\n',count);
    end
    b=toc;
    fprintf('%f\n',b);
    fprintf('GP���\n');
    % IP�б�
    for count=1:21756
        fp1=fullfile(porecoderoot,[num2str(IP(count,1)),'_',num2str(IP(count,2)),'_',num2str(IP(count,3)),'.txt']);
        fp2=fullfile(porecoderoot,[num2str(IP(count,4)),'_',num2str(IP(count,5)),'_',num2str(IP(count,6)),'.txt']);
        % pore���ױ�ʾ������ȡ
        pore1=load(fp1);
        pore2=load(fp2);  
        num1=size(pore1,1);
        num2=size(pore2,1);
        %����ƥ���֮���    
        Score=zeros(num1,num2);
        for j=1:num1
            for k=1:num2
                fea1=pore1(j,:);
                fea2=pore2(k,:);            
                %����ŷʽ����
                Score(j,k)=sqrt(sum((fea1-fea2).^2));
            end
        end
        Pair =[ ];       
        %%%%  FOR RANSAC
        for j=1:num1
            [m, in]=min(Score(j,:));
            [mv,inv]=min(Score(:,in));
            if (m==mv && inv ==j) 
                Pair = cat(1, Pair, [j in]);
            end
        end
        %%%%  FOR WRANSAC
%         summ=0;
%         for j=1:num1
%             m=min(Score(j,:));
%             summ=summ+m;
%         end
%         threshold=summ/num1;
%         [M,N]=find(Score<=threshold);
%         Pair=[M N];
%         Pair=sortrows(Pair);
        %д��
        dlmwrite(fullfile(outpath,'IP',[num2str(count),'.txt']),Pair);
        fprintf('IP��%d�����\n',count);
    end
    fprintf('IP���\n');
end