import com.google.common.util.concurrent.MoreExecutors
import org.springframework.scheduling.concurrent.ThreadPoolExecutorFactoryBean

// Place your Spring DSL code here
beans = {

    httpExecutor(ThreadPoolExecutorFactoryBean) {
        corePoolSize = '${webapi.heartbeat.threads}'
    }
}
