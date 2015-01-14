package com.hanleon.Calibration
{
	import com.hanleon.Mat.Matrix.MatrixAT
	import com.hanleon.Mat.Matrix.MatrixMxN
	import com.hanleon.Mat.Matrix.EigenvalueMxM
	public class Calibration extends Array
	{
		var T:Array=new Array()
		function Calibration(points_original:Array,points_new:Array)
		{
			var P:Array=new Array()
			for(var i:int=0;i<4;i++)
			{
				P[2*i]=new Array()
				P[2*i+1]=new Array()
				
				P[2*i][0]=points_original[i].x
				P[2*i][1]=points_original[i].y
				P[2*i][2]=1
				P[2*i][3]=0
				P[2*i][4]=0
				P[2*i][5]=0
				P[2*i][6]=-points_new[i].x*points_original[i].x
				P[2*i][7]=-points_new[i].x*points_original[i].y
				P[2*i][8]=-points_new[i].x
				
				P[2*i+1][0]=0
				P[2*i+1][1]=0
				P[2*i+1][2]=0
				P[2*i+1][3]=points_original[i].x
				P[2*i+1][4]=points_original[i].y
				P[2*i+1][5]=1
				P[2*i+1][6]=-points_new[i].y*points_original[i].x
				P[2*i+1][7]=-points_new[i].y*points_original[i].y
				P[2*i+1][8]=-points_new[i].y
			}
			//trace(P)
			var Pt:Array=new MatrixAT(P).output_MatrixAT
			var PtP:Array=new MatrixMxN(Pt,P).output_MatrixMxN
			
			var eigenvalue:EigenvalueMxM=new EigenvalueMxM(PtP)
			var vec:Array=eigenvalue.getV
			//var t:Array=new Array()
			for(var k:int=0; k<9; k++) 
			{
				T[k]=vec[k][0]/vec[8][0];
			}
			
		}
		
		public function get output_T():Array
		{
			return T;
		}
	}
}