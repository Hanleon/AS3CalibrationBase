package com.hanleon.Calibration
{
	import flash.geom.Matrix3D;

	public class TransformatAS3 extends Array
	{
		private var m3d:Matrix3D
		function TransformatAS3(T:Array)
		{
			m3d = new Matrix3D(Vector.<Number> ([
								T[0], T[3], 0.0, T[6] / 20,
								T[1], T[4], 0.0, T[7] / 20,
								0.0, 0.0, 1.0, 0.0,
								T[2], T[5], 0.0, T[8]
								]));
		}
		
		public function get output_T():Matrix3D
		{
			return m3d;
		}
	}
}