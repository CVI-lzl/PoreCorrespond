function FPP_Selected_DP_Cord(length)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵�� 
    Listroot=fullfile('E:\OCT\ƥ�亹��_DP\',['DP_List_Large_',num2str(length)]);
    Coderoot=fullfile('E:\OCT\��ȡ����\Large',['NEW_ASS_',num2str(floor(length/2))]);
    outpath=fullfile('E:\OCT\��ȡ����\Large',['NEW_ASS_DP_',num2str(floor(length/2))]);
    for j=1:168
        for k=1:2
            for l=1:5
                Listpath=fullfile(Listroot,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                if(exist(Listpath,'file')~=0)
                    Label=load(Listpath);
                    Cord=load(fullfile(Coderoot,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']));
                    A=Cord(Label,:);
                    dlmwrite(fullfile(outpath,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']),A);
                    fprintf('��%d_%d_%d����ָ���\n',j,k,l);
                else
                    fprintf('��%d_%d_%d����ָ������\n',j,k,l);
                end
            end
        end
    end
end