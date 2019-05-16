package co.yiiu.pybbs.directive;

import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.service.DocumentCenterService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import freemarker.core.Environment;
import freemarker.template.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Component
public class DocumentDirective implements TemplateDirectiveModel
{
    @Autowired
    private DocumentCenterService documentCenterService;

    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException
    {
        Integer pageNo = Integer.parseInt(map.get("pageNo").toString());
        IPage<Document> page=documentCenterService.selectAll(pageNo);
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_28);
        environment.setVariable("page", builder.build().wrap(page));
        templateDirectiveBody.render(environment.getOut());
    }
}
