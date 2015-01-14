package com.hanleon.Mat.Matrix 
{
	public class MatrixMxN extends Array {
		var C: Array = new Array()
		function MatrixMxN(A: Array, B: Array) {
			var M:Array=A
			var N:Array=B
			/*if(A.length>B.length)
			{
				A=N
				B=M
			}*/
			var numRowsA: int = A.length;
			var numRowsB: int = B.length;
			var numColumnsB: int = B[0].length;
			var sum: Number
			for (var i: int = 0; i < numRowsA; i++) {
				C[i]=new Array()
				for (var j: int = 0; j < numColumnsB; j++) {
					sum = 0
					for (var k: int = 0; k < numRowsB; k++) {
						sum += A[i][k] * B[k][j];
					}
					C[i][j] = sum;
				}
			}
		}
	
		public function get output_MatrixMxN(): Array {
			return C;
		}
	}
}