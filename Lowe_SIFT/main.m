function bla = main(absolute_folder)
    
    files = dir(sprintf('%s/%s', absolute_folder, 'im*'));
    total = size(files,1);
    name_im1 = sprintf('%s/%s', files(1).folder, files(1).name);
    im1 = imread(name_im1);
    for cnt = 2 : total
        name_imc = sprintf('%s/%s', files(cnt).folder, files(cnt).name);
        H = homography(name_im1, name_imc);
        H_truth_file = sprintf('%s/%s', absolute_folder, sprintf('H1to%dp', cnt));
        H_truth = importdata(H_truth_file);
        [new_im1, bla1] = imTrans(im1, H);
        [new_imc, bla2] = imTrans(im1, H_truth);
        subplot(1,2,1), imshow(new_im1);
        subplot(1,2,2), imshow(new_imc);
        pause(2);
        
    end
end