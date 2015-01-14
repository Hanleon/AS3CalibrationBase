package com.hanleon.Mat.Matrix 
{
	public class Data extends Array 
	{
		var data:Array = new Array()
		function Data(A:Array) 
		{
			for(var i:int=0;i<A.length;i++)
			{
				for(var j:int=0;j<A[i].length;j++)
				{
					data[data.length]=A[i][j]
				}
			}
		}

		public function get output_data():Array 
		{
			return data;
		}
	}
}