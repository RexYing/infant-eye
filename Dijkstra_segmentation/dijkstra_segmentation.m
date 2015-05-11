function Bt = dijkstra_segmentation(I,opts)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    opts = dijkstra_seg_defaults;
end

I = normalize_image(I,1);
A = build_graph_points_lattice(I,opts.a,opts.w);
A = normalize_image(A,1);
Bt = zeros(size(I));
k = 0;
i = 1;
while k == 0
    [p,p2,cm,p3] = pick_vessel_points(I,1,opts.sx2,opts.sy2,opts.t9,opts.t10);
    if ~isempty(p3)
        if I(p3) < opts.t11
            B = dijkstra_seg_single(A,p3,I,Inf,opts.exp_thr,opts.t2,...
                opts.flt_thr,opts.c,opts.t12);
            I(B > 0) = 1;
            Bt = max(Bt,B);
            i = i + 1;
        else
            I(p3)
            k = 1;
        end
    else
        k = 1;
    end
end
