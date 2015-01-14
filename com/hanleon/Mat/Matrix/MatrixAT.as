package com.hanleon.Mat.Matrix
{
	public class MatrixAT extends Array
	{
		var MatrixAT_arr:Array=new Array()
		function MatrixAT(A:Array)
		{
			for(var i:int=0;i<A[0].length;i++)
			{
				MatrixAT_arr[i]=new Array
				for(var j:int=0;j<A.length;j++)
				{
					MatrixAT_arr[i][j]=A[j][i]
				}
			}
		}
		public function get output_MatrixAT():Array
		{
			return MatrixAT_arr;
		}
	}
}