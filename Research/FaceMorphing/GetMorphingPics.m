function [suc]= GetMorphingPics(control_group_src, control_group_des, img_src, img_des, pic_num)
    src_x(1:4,1:4) = control_group_src(1,1:4,1:4);
    src_y(1:4,1:4) = control_group_src(2,1:4,1:4);
    des_x(1:4,1:4) = control_group_des(1,1:4,1:4);
    des_y(1:4,1:4) = control_group_des(2,1:4,1:4);
    median_xs = interpolation(src_x, des_x, pic_num);
    median_ys = interpolation(src_y, des_y, pic_num);
    suc = false;
    for i=1:pic_num
        if i==1
            img_name = ['Data\' int2str(i) '.jpg'];
            imwrite(img_src, img_name, 'JPG');
           continue;
        end
        if i==pic_num
            img_name = ['Data\' int2str(i) '.jpg'];
            imwrite(img_des, img_name, 'JPG');
            continue;
        end
        median_x(1:4,1:4) = median_xs(i,1:4,1:4);
        median_y(1:4,1:4) = median_ys(i,1:4,1:4);
        percent = i/pic_num;
        img_tmp_1 = GetMidianImg(img_src, src_x, src_y, median_x, median_y);
        img_tmp_2 = GetMidianImg(img_des, des_x, des_y, median_x, median_y);
        img_tmp = img_tmp_1*(1-percent) + img_tmp_2*percent; 
        img_name = ['Data\' int2str(i) '.jpg'];
        imwrite(img_tmp/256, img_name, 'JPG');
    end
    suc = true;
end