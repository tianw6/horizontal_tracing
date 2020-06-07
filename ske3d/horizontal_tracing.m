clear all; close all; clc

dataDir = '/Users/tianwang/Desktop/research/horizontal_tracing/horizontal/';
file_type = '.jpg';

image_num = 5;
for ii = 1 : image_num
    full_name = [dataDir 'h' num2str(ii) file_type];
    % raw data of all images 
    data(:,:,ii) = im2bw(imread(full_name));
end

% check one specific image layer
% I = imread('/Users/tianwang/Desktop/research/horizontal_tracing/ske3d/Feb_h6_test/h6_5.jpg');
% imshow(I);


%% 3D skele
skel = Skeleton3D(data);

%% connect of 2 segments 

ang_limit = pi/3;
dis_limit = 40;

test_img = skel(:,:,5);
endpoints = [49,69;59,95;61,99;67,108;68,110;71,119;87,167;93,198;87,149;95,155];

figure;
imshow(test_img);

% hold on
% pos = [87,149;84,159];    % with other points, not working
% plot(pos(1,1), pos(1,2), 'r*');
% plot(pos(2,1), pos(2,2), 'r*');
% test_result = connect_segment(ang_limit, dis_limit, test_img, pos); 


hold on
for num = 1 : size(endpoints,1)
    plot(endpoints(num,1), endpoints(num,2), 'go');
end

% connect segments
for n = 1 : size(endpoints,1)/2
    pos = [endpoints(2*n-1,:); endpoints(2*n,:)]
    test_result = connect_segment(ang_limit, dis_limit, test_img, pos,1/3,1/3,1/3); 
    test_img = test_result;
end

% temp1 = test_img(pos(1,2)- 1: pos(1,2) + 1, pos(1,1)- 1: pos(1,1) + 1);
% temp1(2,2) = 0;
% [x1,y1] = find(temp1 == 1);
% v1 = [2,2] - [x1,y1];
% 
% v2 = [pos(2,2) - pos(1,2), pos(2,1) - pos(1,1)];
% % test_result = connect(test_img, 73,124,84,159);
% 
% temp2 = test_img(pos(2,2)- 1: pos(2,2) + 1, pos(2,1)- 1: pos(2,1) + 1);
% temp2(2,2) = 0;
% [x2,y2] = find(temp2 == 1);
% v3 = [x2,y2] - [2,2];
% 
% % v1 & v2 angle
% theta12 = abs(acos(dot(v1,v2)/(norm(v1) * norm(v2))));
% % v2 % v3 angle
% theta23 = abs(acos(dot(v2,v3)/(norm(v2) * norm(v3))));
% % distance
% dis = norm(v2);
% % if all satistfied
% 
% if theta12 < ang_limit & theta23 < ang_limit & dis < dis_limit  
%     test_result = connect(test_img, pos(1,1), pos(1,2), pos(2,1), pos(2,2));
% else 
%     test_result = test_img;
% end

figure;
imshow(test_result);

skel(:,:,5) = test_result;
%% plot the result
clc
figure();
%set the color
col=[.7 .7 .8];
hiso = patch(isosurface(data,0),'FaceColor',col,'EdgeColor','none');
hiso2 = patch(isocaps(data,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;

%decoration
isonormals(data,hiso);
lighting phong;
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;

hold on;
w=size(skel,1);
l=size(skel,2);
h=size(skel,3);
[x,y,z]=ind2sub([w,l,h],find(skel(:)));
plot3(y,x,z,'square','Markersize',4,'MarkerFaceColor','r','Color','r');            
set(gcf,'Color','white');
view(140,80)

%%
% 
% test = zeros(size(data,1), size(data,2), 2*size(data, 3));
% for mm = 1 : size(data, 3)
%     test(:,:,mm*2) = skel(:,:,mm);
% end
% %%
% result = zeros(size(test));
% 
% for ll = 1 : size(test,1)
%     for ww = 1 : size(test,2)
%         pixel_sum = sum(test(ll,ww, :));
%         if pixel_sum > 1
%             pos = [];
%             for dd = 1 : size(test,3)
%                 if test(ll,ww,dd) == 1
%                     pos = [pos, dd];
%                 end
%             end
%             result(ll,ww,round(sum(pos)/pixel_sum)) = 1;
%         end
%         pixel_sum = 0;
%     end
% end
% %%
% w=size(result,1);
% l=size(result,2);
% h=size(result,3);
% [x,y,z]=ind2sub([w,l,h],find(result(:)));
% plot3(y,x,z,'square','Markersize',4,'MarkerFaceColor','r','Color','r');            
% set(gcf,'Color','white');
% view(140,80)


