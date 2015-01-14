package com.hanleon.Mat.Matrix
{
	public class InverseMxM extends Array
	{
		var A_1:Array=new Array()
		var LU:Array=new Array();
		var numRows:int
		var numColumns:int
		var pivsign:int
		var piv:Array=new Array();
		function InverseMxM(A:Array)
		{
			numColumns = A[0].length; 
			numRows = A.length;
			var ide:Array=identity(numRows);
			
			
			// Use a "left-looking", dot-product, Crout/Doolittle algorithm.
			LU = A;
			numRows = A.length;
			numColumns = A[0].length;
			for (var i:int = 0; i < numRows; i++) {
				piv[i] = i;
			}
			pivsign = 1;
			var LUrowi:Array=new Array();
			var LUcolj:Array=new Array();
			
			// Outer loop.
			var s:Number
			for (var j:int = 0; j < numColumns;j++) 
			{
				for (var i_2:int = 0; i_2 < numRows; i_2++) 
				{
					LUcolj[i_2] = LU[i_2][j];
				}
				
				for (var i_3:int = 0; i_3 < numRows; i_3++) 
				{
					
					LUrowi = LU[i_3];
					
					var kmax:int = Math.min(i_3,j);
					s=0
					for (var k_3:int = 0; k_3 < kmax; k_3++)
					{
						s += LUrowi[k_3]*LUcolj[k_3];
					}
	
					LUrowi[j] -= s;
					LUcolj[i_3] = LUrowi[j] 
				}
				
				// Find pivot and exchange if necessary.
	
				var p:int = j;
				for (var i_4:int = j+1; i_4 < numRows; i_4++) {
					if (Math.abs(LUcolj[i_4]) > Math.abs(LUcolj[p])) {
						p = i_4;
					}
				}
				if (p != j) {
					for (var k_5 = 0; k_5 < numColumns; k_5++) {
						var t:Number = LU[p][k_5]
						LU[p][k_5] = LU[j][k_5]
						LU[j][k_5] = t;
					}
					var k:int = piv[p]
					piv[p] = piv[j]
					piv[j] = k;
					pivsign = -pivsign;
				}
	
				// Compute multipliers.
				if (j < numRows && LU[j][j] != 0.0) 
				{
					for (var i_6 = j+1; i_6 < numRows; i_6++) 
					{
						LU[i_6][j] /= LU[j][j];
					}
				}
			}
			
			
			A_1=solve(ide)
		}
		
		public function get output_A_1():Array
		{
			return A_1;
		}
		
		
		private function identity(dimension:int)
		{
			var A:Array=new Array()
			for(var i:int=0; i<dimension; i++)
			{
				A[i]=new Array()
				for(var j:int=0; j<dimension; j++)
				{
					if(j==i)
					{
						A[i][j] = 1;
					}
					else
					{
						A[i][j] = 0;
					}
				}
			}
			return A;
		}
		
		private function solve (B:Array) 
		{
			// Copy right hand side with pivoting
			var nx:int = B[0].length;
			var X:Array = subMatrix(B, piv, 0, nx-1);
			
			// Solve L*Y = B(piv,:)
			for (var k:int = 0; k < numColumns; k++) 
			{
				for (var i:int = k+1; i < numColumns; i++) 
				{
					for (var j:int = 0; j < nx; j++) 
					{
						X[i][j] -= X[k][j]*LU[i][k];
					}
				}
			}
			
			// Solve U*X = Y;
			for (var k_2:int = numColumns-1; k_2 >= 0; k_2--) 
			{
				for (var j_2:int = 0; j_2 < nx; j_2++) 
				{
					X[k_2][j_2] /= LU[k_2][k_2];
				}
				for (var i_3:int = 0; i_3 < k_2; i_3++) 
				{
					for (var j_3:int = 0; j_3 < nx; j_3++)
					{
						X[i_3][j_3] -= X[k_2][j_3]*LU[i_3][k_2];
					}
				}
			}
			return X;
		}
		
		private function subMatrix(inputMat:Array,rowIndices:Array,columnStart:int,columnEnd:int) 
		{
			var numRows:int = rowIndices.length;
			var numColumns:int = columnEnd-columnStart+1;
			var outputMat:Array = new Array()
			for (var i:int = 0; i<numRows; i++)
			{
				outputMat[i]=new Array()
			for (var j:int = 0; j<numColumns; j++) 
			{
				outputMat[i][j] = inputMat[rowIndices[i]][j+columnStart];
			}
		  }
		  return outputMat;
		}
		
	}
}