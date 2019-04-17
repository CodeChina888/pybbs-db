package co.yiiu.pybbs.service;

import co.yiiu.pybbs.model.Softcategory;
import co.yiiu.pybbs.service.UploadFileServies;
import com.baomidou.mybatisplus.core.metadata.IPage;
import freemarker.core.Environment;
import freemarker.template.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Component
public class SoftwareDirective implements TemplateDirectiveModel
{
    @Autowired
    private UploadFileServies uploadFileServies;

    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException
    {   System.out.println("进来了吗");
        Integer pageNo = Integer.parseInt(map.get("pageNo").toString());
        Integer pageSize = Integer.parseInt(map.get("pageSize").toString());
        IPage<Softcategory> page=uploadFileServies.selectAllCategory(pageNo, pageSize, null);
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_28);
        environment.setVariable("page", builder.build().wrap(page));
        templateDirectiveBody.render(environment.getOut());
    }
}
