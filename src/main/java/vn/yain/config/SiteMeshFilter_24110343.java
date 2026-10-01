package vn.yain.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.webapp.DispatchMode;

public class SiteMeshFilter_24110343 extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setDispatchMode(DispatchMode.INCLUDE)
               .setDecoratorPrefix("/WEB-INF/decorators/")
               .addDecoratorPath("/admin/*", "admin.jsp")
               .addDecoratorPath("/*", "web.jsp")
               .addExcludedPath("/")
               .addExcludedPath("/index.jsp")
               .addExcludedPath("/static/*")
               .addExcludedPath("/assets/*");
    }
}
