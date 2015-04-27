%visualization.VesselMeasures.main([]);
[h, w] = size(img);
imgT = img';
vesselMeasures = visualization.VesselMeasures(imgT(:), w, h);