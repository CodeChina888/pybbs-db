package co.yiiu.pybbs.model;


import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class SoftwareLabel
{
    private int softwareId;
    private int labelId;
}
