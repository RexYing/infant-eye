package visualization;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.IndexColorModel;
import java.awt.image.WritableRaster;

import javax.swing.JComponent;

public class VesselImage extends JComponent {
	private static final long serialVersionUID = 1L;

	private Image vesselImg;

	VesselImage(int[] imgData, int width, int height) {
		vesselImg = getBinaryImageFromArray(imgData, width, height);
	}

	public Image getBinaryImageFromArray(int[] pixels, int width, int height) {
		// create the binary mapping
		byte BLACK = (byte) 0, WHITE = (byte) 255;
		byte[] map = { BLACK, WHITE };
		IndexColorModel icm = new IndexColorModel(1, map.length, map, map, map);

		WritableRaster raster = icm.createCompatibleWritableRaster(width, height);
		raster.setPixels(0, 0, width, height, pixels);
		BufferedImage image = new BufferedImage(icm, raster, false, null);
		return image;
	}

	@Override
	public void paint(Graphics g) {
		super.paint(g);
		g.drawImage(vesselImg, 0, 0, null);
	}
}
