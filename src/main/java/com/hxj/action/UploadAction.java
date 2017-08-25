package com.hxj.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by hxj on 17-8-16.
 */
@Controller
public class UploadAction{

    private Map<String,Object> responseJson;

    public UploadAction(){
        responseJson = new HashMap<String, Object>();
        responseJson.put("error",0);
    }

    @RequestMapping("/download")
    public String download(HttpServletRequest request, HttpServletResponse response, @RequestParam("filename") String filename)
    {
        String downloadPath = request.getServletContext().getRealPath(File.separator+"download"+File.separator+filename);
        File descFile = new File(downloadPath);
        if(!descFile.exists()){
            return null;
        }

        response.setHeader("Content-Disposition","attachment;filename="+filename);
        response.setContentType("application/octet-stream");

        InputStream is = null;
        OutputStream os = null;
        try {

            is = new FileInputStream(descFile);
            os = response.getOutputStream();

            int len = 0;
            byte[] buffer = new byte[1024];
            while ((len = is.read(buffer)) > 0) {
                os.write(buffer, 0, len);
                os.flush();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if (os!=null){
                try {
                    os.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
            if (is!=null){
                try {
                    is.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }

        return null;
    }


    /*
     *采用spring提供的上传文件的方法
     */
    @RequestMapping("/upload")
    @ResponseBody
    public Object  upload(HttpServletRequest request)
    {
        String savePath = request.getServletContext().getRealPath("/upload");

        File saveDir = new File(savePath);
        if(!saveDir.exists()){
            saveDir.mkdirs();
        }
        String newFileName = "";
        long  startTime=System.currentTimeMillis();
        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if(multipartResolver.isMultipart(request))
        {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
            //获取multiRequest 中所有的文件名
            Iterator iter=multiRequest.getFileNames();

            while(iter.hasNext())
            {
                //一次遍历所有文件
                MultipartFile file=multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                   newFileName = startTime+file.getOriginalFilename();
                    String path=saveDir.getPath()+File.separator+newFileName;
                    //上传
                    try {
                        file.transferTo(new File(path));
                    } catch (IOException e) {
                        responseJson.put("error",1);
                        responseJson.put("msg","上传文件失败，请重试");
                        return responseJson;
                    }
                }
            }
        }
        long  endTime=System.currentTimeMillis();
        System.out.println("方法三的运行时间："+String.valueOf(endTime-startTime)+"ms");

        System.out.println("newFileName:"+newFileName);
        responseJson.put("error",0);
        responseJson.put("msg",newFileName);
        return responseJson;
    }

}
