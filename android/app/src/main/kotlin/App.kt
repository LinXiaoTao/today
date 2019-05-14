import android.app.Application
import com.leo.personal.today.util.GlobalContext

/**
 * @author weimian
 * Created on 2019-05-11 12:20
 */
class App : Application() {

    override fun onCreate() {
        super.onCreate()
        GlobalContext.initContext(this)
    }
}