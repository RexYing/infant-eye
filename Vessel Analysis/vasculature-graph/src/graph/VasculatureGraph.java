package graph;

import java.awt.geom.Point2D;
import java.util.HashMap;
import java.util.Map;

public class VasculatureGraph {
	
	/** Vertices that represent end-points, bifurcations or intersections */
	private Map<Point2D, Integer> keyVIndex = new HashMap<>();
	
	
	public VasculatureGraph(double[][] keyVPos) {
		if (keyVPos.length == 0 || keyVPos[0].length != 2) {
			System.err.println("Input not valid: need n-by-2 array of 2D pixel position");
		}
		else {
			// matlab index starts from 1
			int ind = 1;
			for (double[] p : keyVPos) {
				keyVIndex.put(new Point2D.Double(p[0], p[1]), ind);
				ind++;
			}
		}
	}
	
	public int getKeyV(double[] pos) {
		return keyVIndex.get(new Point2D.Double(pos[0], pos[1]));
	}
	
	public int getKeyVSize() {
		return keyVIndex.size();
	}

	@Override
	public String toString() {
		return "Vasculature graph of size";
	}
}
