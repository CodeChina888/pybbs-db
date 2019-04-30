package co.yiiu.pybbs.model;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class DocumentLabel {
    private Integer docId;
    private Integer labelId;
}
