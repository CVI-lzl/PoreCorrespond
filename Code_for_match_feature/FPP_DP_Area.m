function FPP_DP_Area(select_size)
%   ��ȡdistinctive pore������
%   �˴���ʾ��ϸ˵��
    prootpath = 'E:\OCT\ƥ�亹��\FULL\Minu\';
    realID = 'E:\OCT\��ȡ����\Large\ASS\';
    for j=1:168 
        for k=1:2
            for l=1:5
                porepath = fullfile(prootpath,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                realpath = fullfile(realID,[num2str(j),'_',num2str(k),'_',num2str(l),'.txt']);
                image = zeros(480,640);
                if(exist(realpath, 'file')~=0)
                    pore = load(porepath);
                    row = size(pore, 1);
                    for ii = 1:row
                        x = pore(ii,2);
                        y = pore(ii,1);
                        for xi=1:480
                            for yi=1:640
                                if (norm([xi yi]-[x y])<=select_size)
                                    image(xi,yi)=255;
                                end
                            end
                        end
                    end             
                    imwrite(image,fullfile('E:\OCT\��ȡ����\Large\DP_Area',[num2str(j),'_',num2str(k),'_',num2str(l),'.bmp']));
                    fprintf('��%d_%d_%d����ָ���\n',j,k,l);
                else
                    fprintf('��%d_%d_%d����ָ������\n',j,k,l);
                end
            end
        end
    end
end