package visualization;

import javax.swing.GroupLayout;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;

//import statements
//Check if window closes automatically. Otherwise add suitable code
public class VesselMeasures extends JFrame {

	private static final long serialVersionUID = 1L;

	public VesselMeasures(int[] imgData, int width, int height) {
		JLabel title = new JLabel("Vessel Measures");

		GroupLayout layout = new GroupLayout(getContentPane());
		getContentPane().setLayout(layout);
		layout.setAutoCreateGaps(true);
		layout.setAutoCreateContainerGaps(true);

		JComponent imageComp = new VesselImage(imgData, width, height);
		layout.setHorizontalGroup(layout
				.createSequentialGroup()
				.addGroup(layout.createParallelGroup(GroupLayout.Alignment.CENTER)
						.addComponent(title)
						.addComponent(imageComp))
			);

		layout.setVerticalGroup(
			   layout.createSequentialGroup()
			      .addComponent(title)
			      .addComponent(imageComp)
			);
		
		setSize(640, 480);
		//pack();
		setVisible(true);
	}

	public static void main(String args[]) {
		int[] img = new int[10000];
		for (int i = 0; i < 2000; i++)
			img[i * 3] = 1;
		new VesselMeasures(img, 100, 100);
	}
}
