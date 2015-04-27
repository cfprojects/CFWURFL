import java.io.File;
import java.io.File;
import java.io.FilenameFilter;

public class FileExtensionFilter implements FilenameFilter{
	private String fileExt;
	public FileExtensionFilter(String fileExt) {
	   this.fileExt = fileExt.toLowerCase();
	}
	
	public boolean accept(File dir, String name)  {
	   if (name.toLowerCase().endsWith(this.fileExt)) {
	       return true;
	   }
	   return false;
	}
}