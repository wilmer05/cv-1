% This function receive two images, compute and return the homography 
function hg = homography(im1, im2)
   
    %The function matcha will compute the sift keypoints for two given images
    %will return the descriptors for each images, the (row, column, scale,
    %orientation) in the locaX matrix, the matching points and the quantity
    %of it
   [desc1 loca1 desc2 loca2 matchings mnb] = match(im1, im2);
   
   %This function receive the location of the keypoints and matchings 
   %found in each image in the previous step and will return two matrix
   %pts1 and pts2 with the coordinates of the correct matches
   [pts1 pts2] = get_matching_pts(loca1, loca2, matchings);
   
   %This variable define the threshold to consider a datapoint a inlier or
   %not
   threshold = 0.0001;
   
   % ransacfithomography will receive the matched keypoints and the defined
   % threshold. It will find the best model that fit the given data, and it
   % will return the homography for both images and the points that were
   % inliers for the final model
   [hg, inliers] = ransacfithomography(pts1, pts2, threshold);
end