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
 
package org.opentween.properties {
	import org.opentween.OpenTween;
	import org.opentween.core.AbstractProperty;
	import org.opentween.core.ITweenableProperty;

	import flash.geom.ColorTransform;
	public class ColorTransformProperty extends AbstractProperty implements ITweenableProperty {
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @version: 0.1.0
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  
		
		public static function addProperties():void{
			OpenTween.addProperties("tint", "tint", ColorTransformProperty);
			OpenTween.addProperties("removeTint", "removeTint", ColorTransformProperty);
		}
		
		public override function read(targ:Object):void {
			_begin = targ.transform.colorTransform;
		}
		
		public override function write(targ:Object, position:Number):void {
			var n:Number = position;
          	var r:Number = 1 - n;
          	var ect:ColorTransform = new ColorTransform();
          	if(_prop != "removeTint") ect.color = uint(_end);
          	
			targ.transform.colorTransform = new ColorTransform(
				_begin.redMultiplier * r + ect.redMultiplier * n,
				_begin.greenMultiplier * r + ect.greenMultiplier * n,
				_begin.blueMultiplier * r + ect.blueMultiplier * n,
				_begin.alphaMultiplier * r + ect.alphaMultiplier * n,
				_begin.redOffset * r + ect.redOffset * n,
				_begin.greenOffset * r + ect.greenOffset * n,
				_begin.blueOffset * r + ect.blueOffset * n,
				_begin.alphaOffset * r + ect.alphaOffset * n
			);
		}
		
		public override function difference(useRelative:Boolean):void {
			
		}
	}
}
