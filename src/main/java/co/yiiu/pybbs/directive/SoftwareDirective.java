package co.yiiu.pybbs.directive;

import co.yiiu.pybbs.model.Software;
import co.yiiu.pybbs.service.SoftwareService;
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
    private SoftwareService softwareService;

    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException
    {
        Integer pageNo = Integer.parseInt(map.get("pageNo").toString());
        IPage<Software> page;
        if (map.get("keyword")!=null) {
            String keyword=map.get("keyword").toString();
            page=softwareService.selectAll(pageNo,keyword);
        } else {
            page=softwareService.selectAll(pageNo,null);
        }
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_28);
        environment.setVariable("page", builder.build().wrap(page));
        templateDirectiveBody.render(environment.getOut());
    }
}
