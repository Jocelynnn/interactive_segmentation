% SPDBSCAN SuperPixel DBSCAN clustering for image segmentation
%
% Usage:  [lc, C, regionsC] = spdbscan(l, Cp, Am, E)
%
% Arguments:  (Note this code is structured assuming the input superpixels
%              have been generated using SLIC)
%       l   - Labeled image of clusters/regions generated by a superpixel
%             algorithm,  such as  SLIC. 
%       Cp  - 5 x Np array, as returned by SLIC. Each column giving the
%             attributes of each superpixel region.  Only the first 3
%             attributes, the Lab colour values, are used. 
%       Am  - An adjacency matrix of the labeled image (also returned by SLIC).
%       E   - Matching tolerance value/distance threshold that controls which
%             superpixels are clustered together.  This value is in L*a*b*
%             colour units.  Try a value in the range 5-10 to start with.
%             Changing the value of E by just 1 unit can give a significant
%             difference. 
%
% Returns:
%        lc - New labeled image corresponding to the new clustered regions of
%             superpixels.
%         C - Cell array of length Nc listing indices of superpixel regions
%             associated with each cluster.
%  regionsC - Array of length Np listing the cluster number associated with
%             each superpixel region.  
%
% This function performs an image segmentation using the DBSCAN algorithm to
% form clusters of superpixels.  In determining the neighbourhood of any
% superpixel the following criterion is used: If any two superpixels are
% adjacent the clustering distance measure is the lab colour distance between
% the colour centres of the two superpixels.  If any two superpixels are not
% adjacent the clustering distance measure is assumed infinite.  The use of an
% adjacency matrix allows the DBSCAN scan algorithm to be efficient in
% determining the neighbourhood of each superpixel.
%
% See also: SLIC, REGIONADJACENCY, DBSCAN, DRAWREGIONBOUNDARIES

% DBSCAN Reference: 
% Martin Ester, Hans-Peter Kriegel, J?rg Sander, Xiaowei Xu (1996). "A
% density-based algorithm for discovering clusters in large spatial databases
% with noise".  Proceedings of the Second International Conference on Knowledge
% Discovery and Data Mining (KDD-96). AAAI Press. pp. 226-231.  
% Also see: http://en.wikipedia.org/wiki/DBSCAN

% Copyright (c) 2013 Peter Kovesi
% Centre for Exploration Targeting
% The University of Western Australia
% peter.kovesi at uwa edu au
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.

% ** To Do: Make the distance measure incorporate some measure of any edge
% continuity that adjacent superpixels might have **
% ** Allow attributes other than Lab colour to be used **

% March 2013
% July  2013  Changes to accommondate superpixel attributes being passed as a
%             struct array

function [lc, C, regionsC] = spdbscan(l, Sp, Am, Ec)
    
    minPts = 1;  
    Np = length(Sp);
    
    regionsC  = zeros(Np,1);
    C     = {};
    Nc    = 0;               % Cluster counter.
    Pvisit = zeros(Np,1);    % Array to keep track of superpixels that have
                             % been visited. 
    for n = 1:Np

       if ~Pvisit(n)                  % If this superpixel not visited yet...
           Pvisit(n) = 1;                          % mark it as visited
           neighbours = regionQueryM(Sp, Am, n, Ec); % and find its neighbours

           % Form a cluster...
           Nc = Nc + 1;      % Increment number of clusters and process
                             % neighbourhood.
                           
           C{Nc} = [n];      % Initialise cluster Nc with point n
           regionsC(n) = Nc; % and mark superpixel n as being a member of cluster Nc.
               
           ind = 1;          % Initialise index into neighbourPts array.
               
           % For each superpixel Sp' in list of neighbours ...
           while ind <= length(neighbours)
               
               nb = neighbours(ind);
               
               if ~Pvisit(nb)        % If this neighbour has not been visited
                   Pvisit(nb) = 1;   % mark it as visited.
                   
                   % Find the neighbours of this neighbour and 
                   % add them to the neighbours list
                   neighboursP = regionQueryM(Sp, Am, nb, Ec);
                   neighbours = [neighbours  neighboursP];
               end            
               
               % If this neighbour nb not yet a member of any cluster add it
               % to this cluster.
               if ~regionsC(nb)  
                   C{Nc} = [C{Nc} nb];
                   regionsC(nb) = Nc;
               end
               
               ind = ind + 1;  % Increment neighbour point index and process
                               % next neighbour
           end

       end
    end
    
    % Generate new labeled image corresponding to the new clustered regions
    lc = zeros(size(l));
    for n = 1:length(regionsC)
        lc(l==n) = regionsC(n);
    end

        
    
%------------------------------------------------------------------------
% Find indices of all superpixels adjacent to superpixel n with mean colour
% difference less than Ec.  Use CMC colour difference measure
%
% Arguments:
%             Sp - The struct array of superpixel attributes
%             An - Adjacency matrix
%              n - Index of superpixel being considered
%             Ec - Colour distance threshold

function neighbours = regionQueryCMC(Sp, Am, n, Ec)
    
    lw = 1;
    neighbours = [];
    
    % Get indices of all superpixels connected to superpixel n
    ind = find(Am(n,:));
    
    for i = ind
        
        dE = cmcdifference([Sp(i).L; Sp(i).a; Sp(i).b],...
                           [Sp(n).L; Sp(n).a; Sp(n).b], lw);
        
        if dE < Ec
            neighbours = [neighbours i];     
        end
    end

    
%------------------------------------------------------------------------
% Find indices of all superpixels adjacent to superpixel n with mean colour
% difference less than Ec.
%
% Arguments:
%             Sp - The struct array of superpixel attributes
%             An - Adjacency matrix
%              n - Index of point of interest
%             Ec - Colour distance threshold

function neighbours = regionQueryM(Sp, Am, n, Ec)
    
    E2 = Ec^2;   
    neighbours = [];
    
    % Get indices of all superpixels connected to superpixel n
    ind = find(Am(n,:));
    
    for i = ind
        % Test if distance^2 < E^2 
        v = [Sp(i).L; Sp(i).a; Sp(i).b] - ...
            [Sp(n).L; Sp(n).a; Sp(n).b];

        dist2 = v'*v;
        if dist2 < E2 
            neighbours = [neighbours i];     
        end
    end
    
    