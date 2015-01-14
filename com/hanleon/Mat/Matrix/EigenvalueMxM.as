package com.hanleon.Mat.Matrix
{
	public class EigenvalueMxM
	{

		private var n: int
		private var d: Array = new Array()
		private var e: Array = new Array()
		private var V: Array = new Array()
		private var H: Array = new Array()
		private var ort: Array = new Array()

		// Symmetric Householder reduction to tridiagonal form
		function EigenvalueMxM(Arg: Array)
		{
			var A: Array = new Array()
			n = Arg[0].length
			for (var arr: int = 0; arr < n; arr++)
			{
				A[arr] = new Array();
				V[arr] = new Array();
				d[arr] = new Array();
				e[arr] = new Array();
			}
			A = Arg
			for (var i: int = 0; i < n; i++)
			{
				for (var j: int = 0; j < n; j++)
				{
					V[i][j] = A[i][j];
				}
			}

			// Tridiagonalize.
			tred2();
			// Diagonalize.
			tql2();

		}

		public function get getV(): Array
		{
			return V;
		}

		public function get getRealEigenvalues(): Array
		{
			return d;
		}

		public function get getImagEigenvalues(): Array
		{
			return e;
		}

		private function tred2()
		{

			for (var j: int = 0; j < n; j++)
			{
				d[j] = V[n - 1][j];
			}
			var scale: Number
			var h: Number
			for (var i: int = n - 1; i > 0; i--)
			{

				// Scale to avoid under/overflow.

				scale = 0;
				h = 0;
				for (var k: int = 0; k < i; k++)
				{
					scale = scale + Math.abs(d[k]);
				}

				if (scale == 0.0)
				{
					e[i] = d[i - 1];
					for (var j_2: int = 0; j_2 < i; j_2++)
					{
						d[j_2] = V[i - 1][j_2];
						V[i][j_2] = 0.0;
						V[j_2][i] = 0.0;
					}

				}
				else
				{

					// Generate Householder vector.

					for (var k_2: int = 0; k_2 < i; k_2++)
					{
						d[k_2] /= scale;
						h += d[k_2] * d[k_2];

					}

					var f: Number = d[i - 1];
					var g: Number = Math.sqrt(h);
					if (f > 0)
					{
						g = -g;
					}
					e[i] = scale * g;
					h = h - f * g;
					d[i - 1] = f - g;

					for (var j3: int = 0; j3 < i; j3++)
					{
						e[j3] = 0.0;
					}

					// Apply similarity transformation to remaining columns.

					for (var j4: int = 0; j4 < i; j4++)
					{
						f = d[j4];
						V[j4][i] = f;
						g = e[j4] + V[j4][j4] * f;
						for (var k4: int = j4 + 1; k4 <= i - 1; k4++)
						{
							g += V[k4][j4] * d[k4];
							e[k4] += V[k4][j4] * f;
						}

						e[j4] = g;
					}

					f = 0;
					for (var j_5: int = 0; j_5 < i; j_5++)
					{
						e[j_5] /= h;
						f += e[j_5] * d[j_5];
					}
					var hh: Number = f / (h + h);
					for (var j_6: int = 0; j_6 < i; j_6++)
					{
						e[j_6] -= hh * d[j_6];

					}
					for (var j_7: int = 0; j_7 < i; j_7++)
					{
						f = d[j_7];
						g = e[j_7];
						for (var k_7: int = j_7; k_7 <= i - 1; k_7++)
						{
							V[k_7][j_7] -= (f * e[k_7] + g * d[k_7]);
						}
						d[j_7] = V[i - 1][j_7];
						V[i][j_7] = 0;
					}
				}
				d[i] = h;
			}

			// Accumulate transformations.

			for (var i_2: int = 0; i_2 < n - 1; i_2++)
			{
				V[n - 1][i_2] = V[i_2][i_2];
				V[i_2][i_2] = 1;
				var h2: Number = d[i_2 + 1];
				if (h2 != 0.0)
				{
					for (var k21: int = 0; k21 <= i_2; k21++)
					{
						d[k21] = V[k21][i_2 + 1] / h2;
					}
					for (var j22: int = 0; j22 <= i_2; j22++)
					{
						var g2: Number = 0.0;
						for (var k22: int = 0; k22 <= i_2; k22++)
						{
							g2 += V[k22][i_2 + 1] * V[k22][j22];
						}
						for (var k23: int = 0; k23 <= i_2; k23++)
						{
							V[k23][j22] -= g2 * d[k23];
						}
					}
				}
				for (var k24: int = 0; k24 <= i_2; k24++)
				{
					V[k24][i_2 + 1] = 0.0;
				}
			}

			for (var j25: int = 0; j25 < n; j25++)
			{
				d[j25] = V[n - 1][j25];
				V[n - 1][j25] = 0.0;
			}
			V[n - 1][n - 1] = 1.0;
			e[0] = 0.0;
		}

		private function tql2()
		{

			//  This is derived from the Algol procedures tql2, by
			//  Bowdler, Martin, Reinsch, and Wilkinson, Handbook for
			//  Auto. Comp., Vol.ii-Linear Algebra, and the corresponding
			//  Fortran subroutine in EISPACK.

			for (var i: int = 1; i < n; i++)
			{
				e[i - 1] = e[i];
			}
			e[n - 1] = 0.0;

			var f: Number = 0.0;
			var tst1: Number = 0.0;
			var eps: Number = Math.pow(2.0, -52.0);
			for (var l: int = 0; l < n; l++)
			{

				// Find small subdiagonal element

				tst1 = Math.max(tst1, Math.abs(d[l]) + Math.abs(e[l]));
				var m: int = l;
				while (m < n)
				{
					if (Math.abs(e[m]) <= eps * tst1)
					{
						break;
					}
					m++;
				}

				// If m == l, d[l] is an eigenvalue,
				// otherwise, iterate.

				if (m > l)
				{
					var iter: int = 0;
					do {
						iter = iter + 1; // (Could check iteration count here.)

						// Compute implicit shift

						var g: Number = d[l];
						var p: Number = (d[l + 1] - g) / (2.0 * e[l]);
						var r: Number = hypot(p, 1.0);
						if (p < 0)
						{
							r = -r;
						}
						d[l] = e[l] / (p + r);
						d[l + 1] = e[l] * (p + r);
						var dl1: Number = d[l + 1];
						var h: Number = g - d[l];
						for (var i2: int = l + 2; i2 < n; i2++)
						{
							d[i2] -= h;
						}
						f = f + h;

						// Implicit QL transformation.

						p = d[m];
						var c: Number = 1.0;
						var c2: Number = c;
						var c3: Number = c;
						var el1: Number = e[l + 1];
						var s: Number = 0.0;
						var s2: Number = 0.0;
						for (var i3: int = m - 1; i3 >= l; i3--)
						{
							c3 = c2;
							c2 = c;
							s2 = s;
							g = c * e[i3];
							h = c * p;
							r = hypot(p, e[i3]);
							e[i3 + 1] = s * r;
							s = e[i3] / r;
							c = p / r;
							p = c * d[i3] - s * g;
							d[i3 + 1] = h + s * (c * g + s * d[i3]);

							// Accumulate transformation.

							for (var k3: int = 0; k3 < n; k3++)
							{
								h = V[k3][i3 + 1];
								V[k3][i3 + 1] = s * V[k3][i3] + c * h;
								V[k3][i3] = c * V[k3][i3] - s * h;
							}
						}
						p = -s * s2 * c3 * el1 * e[l] / dl1;
						e[l] = s * p;
						d[l] = c * p;

						// Check for convergence.

					} while (Math.abs(e[l]) > eps * tst1);
				}
				d[l] = d[l] + f;
				e[l] = 0.0;
			}

			// Sort eigenvalues and corresponding vectors.

			for (var i5: int = 0; i5 < n - 1; i5++)
			{
				var k5: int = i5;
				var p5: Number = d[i5];
				for (var j5: int = i5 + 1; j5 < n; j5++)
				{
					if (d[j5] < p5)
					{
						k5 = j5;
						p5 = d[j5];
					}
				}
				if (k5 != i5)
				{
					d[k5] = d[i5];
					d[i5] = p5;
					for (var j6: int = 0; j6 < n; j6++)
					{
						p5 = V[j6][i5];
						V[j6][i5] = V[j6][k5];
						V[j6][k5] = p5;
					}
				}
			}
		}

		private function hypot(a: Number, b: Number): Number
		{
			var r: Number;
			if (a * a > b * b)
			{
				r = b / a;
				r = Math.abs(a) * Math.sqrt(1 + r * r);
			}
			else if (b != 0)
			{
				r = a / b;
				r = Math.abs(b) * Math.sqrt(1 + r * r);
			}
			else
			{
				r = 0.0;
			}
			return r;
		}
	}
}