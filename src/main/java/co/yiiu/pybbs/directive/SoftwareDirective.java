package co.yiiu.pybbs.directive;

import co.yiiu.pybbs.model.SoftCategory;
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
    {
        Integer pageNo = Integer.parseInt(map.get("pageNo").toString());
        Integer pageSize = Integer.parseInt(map.get("pageSize").toString());
        Integer cgId=Integer.parseInt(map.get("categoryId").toString());
        IPage<SoftCategory> page=uploadFileServies.selectAllCategory(pageNo, pageSize, null,cgId);
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_28);
        environment.setVariable("page", builder.build().wrap(page));
        templateDirectiveBody.render(environment.getOut());
    }
}
