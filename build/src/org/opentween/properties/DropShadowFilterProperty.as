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
	import org.opentween.utils.Utilities;
	import org.opentween.OpenTween;
	import org.opentween.core.AbstractProperty;
	import org.opentween.core.ITweenableProperty;

	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	public class DropShadowFilterProperty extends AbstractProperty implements ITweenableProperty {
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @version: 0.1.0
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  
		
		private const FILTER:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0, 0, 0, 1, 2);
		
		public static function addProperties():void{
			OpenTween.addProperties("DropShadow_alpha", "alpha", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_angle", "angle", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_blurX", "blurX", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_blurY", "blurY", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_color", "color", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_distance", "distance", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_quality", "quality", DropShadowFilterProperty);
			OpenTween.addProperties("DropShadow_strength", "strength", DropShadowFilterProperty);
		}
		
		public override function read(targ:Object):void {
			var defVals:BitmapFilter;
			var filters:Array = targ.filters;
			for (var i:int = 0; i < targ.filters.length; i++) {
				if (filters[i] is DropShadowFilter) {
						_begin = (targ.filters[i][_prop]);
				}
			}
			defVals = FILTER;
			//if(!isNaN(_start)) defVals[_prop] = _start;
			_begin = defVals[_prop];
		}
		
		public override function write(targ:Object, position:Number):void {
			var filters:Array = targ.filters;
			var filter:BitmapFilter;
			for (var i:int = 0; i < filters.length; i++) {
				if (filters[i] is DropShadowFilter) {
					if(_prop != "color"){
						filters[i][_prop] = Number(_begin) + Number(_change) * position;
						targ.filters = filters;
						return;
					}else{
						filters[i][_prop] = Utilities.interpolateColor(uint(_begin), Number(_change), position);
						targ.filters = filters;
						return;
					}
				}
			}
			if (filters == null) filters = [];
			filter = FILTER;
			filter[_prop] = _begin;
			filters.push(filter);
			targ.filters = filters;
		}
		
		public override function difference(useRelative:Boolean):void {
			_change = (useRelative ? _end : Number(_end) - Number(_begin));
		}
	}
}
