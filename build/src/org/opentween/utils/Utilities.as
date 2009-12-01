/**
 * Copyright (c) 2009 Donovan Adams, http://blog.hydrotik.com - donovan (at) hydrotik (dot) com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.opentween.utils {

	public class Utilities {
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @version: 0.1.0
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  

		public static function interpolateColor(fromColor : uint, toColor : uint, progress : Number) : uint {
			var q : Number = 1 - progress;
			var fromA : uint = (fromColor >> 24) & 0xFF;
			var fromR : uint = (fromColor >> 16) & 0xFF;
			var fromG : uint = (fromColor >> 8) & 0xFF;
			var fromB : uint = fromColor & 0xFF;

			var toA : uint = (toColor >> 24) & 0xFF;
			var toR : uint = (toColor >> 16) & 0xFF;
			var toG : uint = (toColor >> 8) & 0xFF;
			var toB : uint = toColor & 0xFF;
		
			var resultA : uint = fromA * q + toA * progress;
			var resultR : uint = fromR * q + toR * progress;
			var resultG : uint = fromG * q + toG * progress;
			var resultB : uint = fromB * q + toB * progress;
			var resultColor : uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
			return resultColor;		
		}
	}
}
