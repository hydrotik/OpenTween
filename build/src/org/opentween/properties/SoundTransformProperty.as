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
	import org.opentween.core.AbstractProperty;
	import org.opentween.core.ITweenableProperty;
	import org.opentween.OpenTween;

	import flash.media.SoundTransform;
	public class SoundTransformProperty extends AbstractProperty implements ITweenableProperty {
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @version: 0.1.0
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  
		
		public static function addProperties():void{
			OpenTween.addProperties("volume", "volume", SoundTransformProperty);
			OpenTween.addProperties("pan", "pan", SoundTransformProperty);
			OpenTween.addProperties("leftToLeft", "leftToLeft", SoundTransformProperty);
			OpenTween.addProperties("leftToRight", "leftToRight", SoundTransformProperty);
			OpenTween.addProperties("rightToLeft", "rightToLeft", SoundTransformProperty);
			OpenTween.addProperties("rightToRight", "rightToRight", SoundTransformProperty);
		}
		
		public override function read(targ:Object):void {
			_begin =  Number(targ.soundTransform[_prop]);
		}
		
		public override function write(targ:Object, position:Number):void {
			var tf:SoundTransform = targ.soundTransform;
            tf[_prop] = Number(_begin) + Number(_change) * position;
            targ.soundTransform = tf;
		}
		
		public override function difference(useRelative:Boolean):void {
			_change = (useRelative ? _end : Number(_end) - Number(_begin));
		}
	}
}
