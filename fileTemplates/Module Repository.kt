#parse("HeaderPkg.kt")

import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
#set( $MODEL1 = $First_Model )
#set( $MODEL2 = $Second_Model )
#set( $MODEL3 = $Third_Model )
#if($MODEL1 != "")
#set( $MODEL1_PLURAL = $MODEL1 + "s" )
#set( $IREPO1 = $MODEL1_PLURAL )
#set( $REPO1 = $IREPO1 + "Repository" )
#set( $ILOCAL1 = "Local" + $MODEL1_PLURAL + "DataSource" )
#set( $LOCAL1 = $ILOCAL1.replace("Local", "Room") )
#set( $IREMOTE1 = "Remote" + $MODEL1_PLURAL + "DataSource" )
#set( $REMOTE1 = $IREMOTE1.replace("Remote","Retrofit") )
import #parse("RootPkg.kt").data.local.$ILOCAL1
import #parse("RootPkg.kt").data.local.$LOCAL1
import #parse("RootPkg.kt").data.remote.$IREMOTE1
import #parse("RootPkg.kt").data.remote.$REMOTE1
import #parse("RootPkg.kt").domain.repository.$IREPO1
import #parse("RootPkg.kt").domain.repository.$REPO1
#end
#if($MODEL2 != "")
#set( $MODEL2_PLURAL = $MODEL2 + "s" )
#set( $IREPO2 = $MODEL2_PLURAL )
#set( $REPO2 = $IREPO2 + "Repository" )
#set( $ILOCAL2 = "Local" + $MODEL2_PLURAL + "DataSource" )
#set( $LOCAL2 = $ILOCAL2.replace("Local", "Room") )
#set( $IREMOTE2 = "Remote" + $MODEL2_PLURAL + "DataSource" )
#set( $REMOTE2 = $IREMOTE2.replace("Remote","Retrofit") )
import #parse("RootPkg.kt").data.local.$ILOCAL2
import #parse("RootPkg.kt").data.local.$LOCAL2
import #parse("RootPkg.kt").data.remote.$IREMOTE2
import #parse("RootPkg.kt").data.remote.$REMOTE2
import #parse("RootPkg.kt").domain.repository.$IREPO2
import #parse("RootPkg.kt").domain.repository.$REPO2
#end
#if($MODEL3 != "")
#set( $MODEL3_PLURAL = $MODEL3 + "s" )
#set( $IREPO3 = $MODEL3_PLURAL )
#set( $REPO3 = $IREPO3 + "Repository" )
#set( $ILOCAL3 = "Local" + $MODEL3_PLURAL + "DataSource" )
#set( $LOCAL3 = $ILOCAL3.replace("Local", "Room") )
#set( $IREMOTE3 = "Remote" + $MODEL3_PLURAL + "DataSource" )
#set( $REMOTE3 = $IREMOTE3.replace("Remote","Retrofit") )
import #parse("RootPkg.kt").data.local.$ILOCAL3
import #parse("RootPkg.kt").data.local.$LOCAL3
import #parse("RootPkg.kt").data.remote.$IREMOTE3
import #parse("RootPkg.kt").data.remote.$REMOTE3
import #parse("RootPkg.kt").domain.repository.$IREPO3
import #parse("RootPkg.kt").domain.repository.$REPO3
#end

@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {
#if($MODEL1 != "")
    // --- $MODEL1_PLURAL
    @Binds abstract fun bind$REPO1(impl: $REPO1): $IREPO1
    @Binds abstract fun bind$IREMOTE1(impl: $REMOTE1): $IREMOTE1
    @Binds abstract fun bind$ILOCAL1(impl: $LOCAL1): $ILOCAL1
#end

#if($MODEL2 != "")
    // --- $MODEL2_PLURAL
    @Binds abstract fun bind$REPO2(impl: $REPO2): $IREPO2
    @Binds abstract fun bind$IREMOTE2(impl: $REMOTE2): $IREMOTE2
    @Binds abstract fun bind$ILOCAL2(impl: $LOCAL2): $ILOCAL2
#end

#if($MODEL3 != "")
    // --- $MODEL3_PLURAL
    @Binds abstract fun bind$REPO3(impl: $REPO3): $IREPO3
    @Binds abstract fun bind$IREMOTE3(impl: $REMOTE3): $IREMOTE3
    @Binds abstract fun bind$ILOCAL3(impl: $LOCAL3): $ILOCAL3
#end
}
