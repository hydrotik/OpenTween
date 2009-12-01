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

package org.opentween.core {
	import org.opentween.core.ITweenableProperty;
	public class AbstractProperty implements ITweenableProperty {
		
		protected var _start:Object;
		protected var _begin:Object;
		protected var _end:Object;
		protected var _change:Object;
		protected var _prop:String;
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @version: 0.1.0
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  
		
		public function read(targ:Object) : void {
			throw new Error("AbstractProperty must be overriden!");
		}
		
		public function write(targ:Object, position:Number) : void {
			throw new Error("AbstractProperty must be overriden!");
		}
		
		public function difference(useRelative:Boolean) : void {
			throw new Error("AbstractProperty must be overriden!");
		}
		
		public function get begin() : Object {
			return _begin;
		}
		
		public function set begin(begin : Object) : void {
			_begin = begin;
		}
		
		public function get end() : Object {
			return _end;
		}
		
		public function set end(end : Object) : void {
			_end = end;
		}
		
		public function get change() : Object {
			return _change;
		}
		
		public function set change(change : Object) : void {
			_change = change;
		}
		
		public function get prop() : String {
			return _prop;
		}
		
		public function set prop(prop : String) : void {
			_prop = prop;
		}
		
		public function get start() : Object {
			return _start;
		}
		
		public function set start(start : Object) : void {
			_start = start;
		}
	}
}
