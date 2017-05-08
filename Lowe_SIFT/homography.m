function hg = homography(im1, im2)
    hg = 0;
   [desc1 loca1 desc2 loca2 matchings mnb] = match(im1, im2);
   [pts1 pts2] = get_matching_pts(loca1, loca2, matchings);
   threshold = 0.0001;
   [hg, inliers] = ransacfithomography(pts1, pts2, threshold);
end