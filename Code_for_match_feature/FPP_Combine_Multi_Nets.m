function FPP_Combine_Multi_Nets(length, K)
%   �ϲ������������Ľ�������������򰴳ߴ磩
%   K=0��ʾ����ͬ�ߴ磬K=1��ʾ����ͬ������ 
%   �˴���ʾ��ϸ˵��
    coderoot=fullfile('E:\OCT\ƥ�亹��_Small\Pore deep feature code'); 
    outpath=fullfile('E:\OCT\ƥ�亹��_Small\Pore deep feature code',num2str(length));
    if K==0
        for j=1:168
            for k=1:2
                for l=1:5
                    code_10000_path = fullfile(coderoot,[num2str(length),'_10000'],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    code_15000_path = fullfile(coderoot,[num2str(length),'_15000'],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    code_20000_path = fullfile(coderoot,[num2str(length),'_20000'],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    if(exist(code_10000_path, 'file')~=0)
                        C_10000=load(code_10000_path);
                        C_15000=load(code_15000_path);
                        C_20000=load(code_20000_path);
                        A = [C_10000 C_15000 C_20000];
                        dlmwrite(fullfile(outpath,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']),A);
                        fprintf('��%d_%d_%d����ָ���\n',j,k,l);
                    else
                        fprintf('��%d_%d_%d����ָ������\n',j,k,l);
                    end
                end
            end     
        end
    elseif K==1
        for j=1:168
            for k=1:2
                for l=1:5
                    s15_code_path = fullfile(coderoot,['15_',num2str(length)],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    s19_code_path = fullfile(coderoot,['19_',num2str(length)],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    s25_code_path = fullfile(coderoot,['25_',num2str(length)],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    s31_code_path = fullfile(coderoot,['31_',num2str(length)],[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    List_15_path = fullfile('E:\OCT\��ȡ����\Small\7_List_For_15',[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    List_19_path = fullfile('E:\OCT\��ȡ����\Small\9_List_For_15',[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    List_25_path = fullfile('E:\OCT\��ȡ����\Small\12_List_For_15',[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                    if(exist(s15_code_path, 'file')~=0)
                        s15_C=load(s15_code_path);
                        s19_C=load(s19_code_path);
                        s25_C=load(s25_code_path);
                        s31_C=load(s31_code_path);
                        List_15=load(List_15_path);
                        List_19=load(List_19_path);
                        List_25=load(List_25_path);
                        S15_C=s15_C(List_15,:);
                        S19_C=s19_C(List_19,:);
                        S25_C=s25_C(List_25,:);
                        A = [S15_C S19_C S25_C s31_C];
                        dlmwrite(fullfile(outpath,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']),A);
                        fprintf('��%d_%d_%d����ָ���\n',j,k,l);
                    else
                        fprintf('��%d_%d_%d����ָ������\n',j,k,l);
                    end
                end
            end     
        end
    end
end