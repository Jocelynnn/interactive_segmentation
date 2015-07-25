function I=quantilize(I,dimension)

I = ceil((double(I) + 0.5) / dimension);

end