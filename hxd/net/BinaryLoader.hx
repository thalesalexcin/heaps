package hxd.net;

class BinaryLoader {

	public var url(default, null) : String;
	#if flash
	var loader : flash.net.URLLoader;
	#end

	public function new( url : String ) {
		this.url = url;
	}

	public dynamic function onLoaded( bytes : haxe.io.Bytes ) {
	}

	public dynamic function onProgress( cur : Int, max : Int ) {
	}

	public dynamic function onError( msg : String ) {
		throw msg;
	}

	public function load() {
		#if flash
		loader = new flash.net.URLLoader();
		loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
		loader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, function(e:flash.events.IOErrorEvent) onError(e.text));
		loader.addEventListener(flash.events.Event.COMPLETE, function(_) onLoaded(haxe.io.Bytes.ofData(loader.data)));
		loader.addEventListener(flash.events.ProgressEvent.PROGRESS, function(e:flash.events.ProgressEvent) onProgress(Std.int(e.bytesLoaded), Std.int(e.bytesTotal)));
		loader.load(new flash.net.URLRequest(url));
		#end
	}

}