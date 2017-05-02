function keypoints = find_extremas( dog, params )
% FIND_EXTREMAS is a function that needs to take as input a computed difference of gaussian space and some parameters. 
% It should return a a binary image where each found extrema has a value of 1 and the rest has value of 0.

% define the search radius
radius = 2;

% intialize keypoints image to have the size of the original input image
keypoints = zeros(size(dog{-params.omin+1}(:,:,1)));
[m n] = size (keypoints);
for o = 1:params.O
    [M,N,S] = size(dog{o}) ;
    
    %disp(size(dog{o}(:,:,1)));
    %disp(dog{o}(:,:,1));
    %disp(dog{o});
    [mo, no] = size(dog{o}(:,:,1));
    for s=2:S-1        
        im1 = dog{o}(:,:,s-1);
        im2 = dog{o}(:,:,s);
        im3 = dog{o}(:,:,s+1);
        for i=1:mo
            for j=1:no
                if minima(im1,im2,im3, j, i, mo, no) || maxima(im1,im2,im3, j, i, mo, no)
                    [yy, xx] = convert_coord(j, i, o, M, N, params);
                    keypoints(yy, xx) = 1;
                end
            end
        end
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%% MISSING CODE HERE %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Helping Instructions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Once you find a minima or a maxima, you could use this set of intructions to set the value in the keypoints image to 1

%                    if(is_minima || is_maxima)
%                        % first transform the point to the coordinate space of the original image
                       %ypt = round(y *2^(params.omin+o-1) ); 
                       %xpt = round(x * 2^(params.omin+o-1) );


end

function [ypt, xpt] = convert_coord(x, y, o, m, n, params)
    ypt = round(y *2^(params.omin+o-1) ); 
    xpt = round(x * 2^(params.omin+o-1) );
    if(ypt < 1 ) 
       ypt = 1;
    elseif (ypt > m) 
           ypt = m;
    end
    if (xpt <1 ) 
       xpt = 1;
    elseif (xpt > n) 
       xpt = n;
    end

     % set the values of keypoints to 1
    
end

function is_minima = minima(im1,im2,im3, px, py, m, n)
    is_minima = true;
    for dx = -1:1
        for dy = -1:1
            nx = px + dx;
            ny = py + dy;
            
            if valid_p(nx, ny, m, n)
                is_minima = is_minima && im2(py,px) < im1(ny, nx) && im2(py, px) < im3(ny, nx);
                if nx ~= px || ny ~= py
                    is_minima = is_minima && im2(py, px) < im2(ny, nx);
                end
            end
        end
    end
    is_minima = is_minima && px ~= 1 && px ~= n && py ~= 1 && py ~= m;
end

function is_maxima = maxima(im1,im2,im3, px, py, m, n)
    is_maxima = true;
    for dx = -1:1
        for dy = -1:1
            nx = px + dx;
            ny = py + dy;
            
            if valid_p(nx, ny, m, n)
                is_maxima = is_maxima && im2(py,px) > im1(ny, nx) && im2(py,px) > im3(ny, nx);
                if nx ~= px || ny ~= py
                    is_maxima = is_maxima && im2(py, px) > im2(ny, nx);
                end
            end
        end
    end
    is_maxima = is_maxima && px ~= 1 && px ~= n && py ~= 1 && py ~= m;
end

function valid_point = valid_p(x, y, m, n)
    valid_point = x >= 1 && x <= n && y >=1 && y <= m;
end