package data;

import data.Category;
import haxe.io.Path;
import util.GitUtil.GitAuthorInfo;
import util.GitUtil.GitDates;

/**
 * @author Mark Knol
 */
@:keep
class Page { 
	public var visible:Bool = true;
	public var title:String;
	public var description:String;
	public var templatePath:Path;
	public var contentPath:Path;
	public var outputPath:Path;
	public var customData:Dynamic;
	public var tags:Array<String>;
	public var absoluteUrl:String;
	public var editUrl:String;
	public var commitHistoryUrl:String;
	public var addLinkUrl:String;
	public var contributionUrl:String;
	public var baseHref:String;
	public var dates:GitDates;
	public var category:data.Category;
	public var authors:Array<GitAuthorInfo> = [];
	public var contributors:Array<GitAuthorInfo> = [];
	public var snippets:Array<String> = [];
	
	public var level:Int;
	
	//only available in series
	public var next:Page;
	public var prev:Page;
	
	public var pageContent:String;
	
	public function new(templatePath:String, contentPath:String, outputPath:String) {
		this.templatePath = new Path(templatePath);
		this.contentPath = contentPath != null ? new Path(contentPath) : null;
		this.outputPath = outputPath != null ? new Path(outputPath) : null;
	}
	
	public function setCustomData(data:Dynamic):Page {
		this.customData = data;
		return this;
	}
	
	public function setTitle(title:String):Page {
		this.title = title;
		return this;
	}
	
	public function setDescription(description:String):Page {
		this.description = description;
		return this;
	}
	
	public function setTags(tags:Array<String>):Page {
		this.tags = tags;
		return this;
	}
	
	public function hidden() {
		visible = false;
		return this;
	}

	public function isSerieHome():Bool {
		return outputPath.toString().indexOf("index.html") != -1;
	}
	
	// Idea adapted from <https://blog.medium.com/read-time-and-you-bc2048ab620c>
	// Read time (in minutes) is based on the average reading speed of an adult: 275 words per minute
	public function getReadTime():Float {
		if (pageContent == null) return 0.0;
		var wordCount = pageContent.split(" ").length; // Dumb assumption, but seems to work
		var minutes = wordCount / 275;
		
		return if (minutes < 5) 
				Math.fround(minutes * 2) / 2; // round to half
			else 
				Math.round(minutes); // just round
	}
}
