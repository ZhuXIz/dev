package com.jdkj.wx.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.xwpf.converter.core.BasicURIResolver;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.util.ResourceUtils;
import org.springframework.web.context.ContextLoader;

import com.jdkj.wx.common.ResponseResult;
//doc格式转换为html
public class DocUtil {
	public static void main(String[] args) throws Exception {
		System.out.println(docToHtml());
	}  
	
	public static String docToHtml() throws Exception {
	    File path = new File(ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload"));
	    String imagePathStr = path + "/doc/images/";
	    String sourceFileName = path+ "/test.doc";
	    
	    String targetFileName="/upload/imgs/goods/"+new Date().getTime()+"_"+new Random().nextInt(1000)+".html";//新的文件名
	    
	    File file = new File(imagePathStr);
	    if(!file.exists()) {
	        file.mkdirs();
	    }
	    HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(sourceFileName));
	    org.w3c.dom.Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
	    WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(document);
	    //保存图片，并返回图片的相对路径
	    wordToHtmlConverter.setPicturesManager((content, pictureType, name, width, height) -> {
	        try (FileOutputStream out = new FileOutputStream(imagePathStr + name)) {
	            out.write(content);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "image/" + name;
	    });
	    wordToHtmlConverter.processDocument(wordDocument);
	    org.w3c.dom.Document htmlDocument = wordToHtmlConverter.getDocument();
	    DOMSource domSource = new DOMSource(htmlDocument);
	    StreamResult streamResult = new StreamResult(new File(targetFileName));
	    TransformerFactory tf = TransformerFactory.newInstance();
	    Transformer serializer = tf.newTransformer();
	    serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
	    serializer.setOutputProperty(OutputKeys.INDENT, "yes");
	    serializer.setOutputProperty(OutputKeys.METHOD, "html");
	    serializer.transform(domSource, streamResult);
	    return targetFileName;
	}
	
	//docx格式转换为html
	public static String docxToHtml() throws Exception {
	    File path = new File(ResourceUtils.getURL("classpath:").getPath());
	    String imagePath = path.getAbsolutePath() + "\\static\\image";
	    String sourceFileName = path.getAbsolutePath() + "\\static\\test.docx";
	    String targetFileName = path.getAbsolutePath() + "\\static\\test.html";

	    OutputStreamWriter outputStreamWriter = null;
	    try {
	        XWPFDocument document = new XWPFDocument(new FileInputStream(sourceFileName));
	        XHTMLOptions options = XHTMLOptions.create();
	        // 存放图片的文件夹
	        options.setExtractor(new FileImageExtractor(new File(imagePath)));
	        // html中图片的路径
	        options.URIResolver(new BasicURIResolver("image"));
	        outputStreamWriter = new OutputStreamWriter(new FileOutputStream(targetFileName), "utf-8");
	        XHTMLConverter xhtmlConverter = (XHTMLConverter) XHTMLConverter.getInstance();
	        xhtmlConverter.convert(document, outputStreamWriter, options);
	    } finally {
	        if (outputStreamWriter != null) {
	            outputStreamWriter.close();
	        }
	    }
	    return targetFileName;
	}

}
