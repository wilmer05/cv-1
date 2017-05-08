%This function receive a folder as parameter
%It will look for all files which name start with 'im' and will compute the
%homography for every two pairs or images found in the given folder
function bla = main(absolute_folder)
    
    files = dir(sprintf('%s/%s', absolute_folder, 'im*'));
    total = size(files,1);
    name_im1 = sprintf('%s/%s', files(1).folder, files(1).name);
    im1 = imread(name_im1);
    for cnt = 2 : total
        name_imc = sprintf('%s/%s', files(cnt).folder, files(cnt).name);
        
        %Compute the homography for two images
        H = homography(name_im1, name_imc);
       
        %Read the truth homography
        H_truth_file = sprintf('%s/%s', absolute_folder, sprintf('H1to%dp', cnt));
        H_truth = importdata(H_truth_file);
        
        %imTrans will transform the image im1 to the corresponding plan
        %for the previously compute homography H
        [new_im1, bla1] = imTrans(im1, H);
        
        %Here the transformation will be compute using the ground truth 
        %homography
        [new_imc, bla2] = imTrans(im1, H_truth);
        
        %Displaying both transformed images
        subplot(1,2,1), imshow(new_im1);
        subplot(1,2,2), imshow(new_imc);
        
        %Computing the error using the Frobenius norm
        msg = sprintf('Frobenius error for images %d y %d = %f', 1, cnt, norm(H - H_truth, 'fro'));
        disp(msg);
        pause(2);
        
    end
end